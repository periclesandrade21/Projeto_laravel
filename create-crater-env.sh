#!/bin/bash

ENV_FILE=".env"

echo "Criando arquivo $ENV_FILE..."

cat > $ENV_FILE <<EOL
# Variáveis para docker-compose.crater.yml

SENTRY_LARAVEL_DSN=https://seu_dsn_aqui
BLACKFIRE_CLIENT_ID=seu_client_id
BLACKFIRE_CLIENT_TOKEN=seu_client_token
BLACKFIRE_SERVER_ID=seu_server_id
BLACKFIRE_SERVER_TOKEN=seu_server_token

# Opcional: habilitar Telescope no Laravel Crater
TELESCOPE_ENABLED=true
EOL

echo "$ENV_FILE criado com sucesso!"
