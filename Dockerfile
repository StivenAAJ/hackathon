# Imagen base PHP 8.3 FPM
FROM php:8.3-fpm

# Instalar dependencias del sistema y extensiones PHP necesarias
RUN apt-get update && apt-get install -y \
    libpq-dev \
    libzip-dev \
    unzip \
    zip \
    git \
    curl \
    libonig-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo_pgsql zip mbstring exif pcntl gd

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Crear directorio de trabajo
WORKDIR /var/www

# Copiar archivos al contenedor
COPY . .

# Instalar dependencias PHP sin dev
RUN composer install --no-dev --optimize-autoloader

# Ajustar permisos para storage y cache
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# Exponer el puerto PHP-FPM
EXPOSE 9000

# Comando para iniciar PHP-FPM
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=10000"]

