FROM php:8.1-apache

# Instalar extensões necessárias
RUN docker-php-ext-install pdo pdo_mysql

# Habilitar mod_rewrite do Apache
RUN a2enmod rewrite

WORKDIR /var/www/html

# Não precisa copiar a aplicação, pois estará montada via volume no docker-compose
