#!/bin/bash

set -e

echo "🌀 Clonando Crater..."
git clone https://github.com/crater-invoice/crater.git crater

cd crater

echo "📦 Instalando dependências..."
docker run --rm -v $(pwd):/app -w /app composer install

echo "🛠️ Copiando .env..."
cp .env.example .env

echo "🔐 Gerando APP_KEY..."
docker run --rm -v $(pwd):/app -w /app webdevops/php-apache-dev:8.1 php artisan key:generate

echo "🔎 Instalando Telescope..."
docker run --rm -v $(pwd):/app -w /app webdevops/php-apache-dev:8.1 composer require laravel/telescope
docker run --rm -v $(pwd):/app -w /app webdevops/php-apache-dev:8.1 php artisan telescope:install
docker run --rm -v $(pwd):/app -w /app webdevops/php-apache-dev:8.1 php artisan migrate

echo "📡 Instalando Sentry..."
docker run --rm -v $(pwd):/app -w /app webdevops/php-apache-dev:8.1 composer require sentry/sentry-laravel

echo "✅ Adicionando rota /health..."
echo "Route::get('/health', fn () => response()->json(['status' => 'ok']));" >> routes/web.php

echo "🧠 Configure o .env com suas chaves:"
echo "
TELESCOPE_ENABLED=true
SENTRY_LARAVEL_DSN=YOUR_SENTRY_DSN
BLACKFIRE_CLIENT_ID=...
BLACKFIRE_CLIENT_TOKEN=...
BLACKFIRE_SERVER_ID=...
BLACKFIRE_SERVER_TOKEN=...
"

echo "🧩 Criando docker-compose.crater.yml..."
cat <<EOF > ../docker-compose.crater.yml
version: '3.8'

services:
  crater:
    image: webdevops/php-apache-dev:8.1
    container_name: crater-app
    working_dir: /var/www/html
    volumes:
      - ./crater:/var/www/html
    ports:
      - "8010:80"
    environment:
      - WEB_DOCUMENT_ROOT=/var/www/html/public
      - PHP_DISPLAY_ERRORS=1
      - BLACKFIRE_CLIENT_ID=your_blackfire_client_id
      - BLACKFIRE_CLIENT_TOKEN=your_blackfire_client_token
      - BLACKFIRE_SERVER_ID=your_blackfire_server_id
      - BLACKFIRE_SERVER_TOKEN=your_blackfire_server_token
    depends_on:
      - crater-db
    healthcheck:
      test: ["CMD-SHELL", "curl -f http://localhost/health || exit 1"]
      interval: 30s
      retries: 3
      start_period: 30s

  crater-db:
    image: mysql:8
    container_name: crater-db
    ports:
      - "3308:3306"
    environment:
      MYSQL_DATABASE=crater
      MYSQL_USER=crater
      MYSQL_PASSWORD=crater
      MYSQL_ROOT_PASSWORD=root
    volumes:
      - crater_db:/var/lib/mysql

volumes:
  crater_db:
EOF

echo "✅ Pronto! Rode com:"
echo "docker-compose -f docker-compose.crater.yml up -d"
