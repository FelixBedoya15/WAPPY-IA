# Usa una imagen base de PHP con FPM
FROM php:8.2-fpm-alpine

# Instala dependencias del sistema y el servidor web Nginx
RUN apk add --no-cache \
    nginx \
    ...

# Establece el directorio de trabajo
WORKDIR /var/www/html

# Copia los archivos de tu proyecto
COPY . .

# Instala las dependencias de Composer y Node.js
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install --no-dev --optimize-autoloader
RUN npm install
RUN npm run build

# Expone el puerto 80, que es el puerto estándar
EXPOSE 80

# Comando para iniciar el servidor Nginx y PHP-FPM
CMD php-fpm -D && nginx -g 'daemon off;'
