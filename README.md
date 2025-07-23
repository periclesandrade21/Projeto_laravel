# Projeto_laravel
Projeto para subir um stack de nota fisca com monitoramento e observabilidade

/mastertax-clone
├── docker-compose.yml
├── docker-compose.monitor.yml
├── docker-compose.crater.yml
├── setup-crater.sh          ← Aqui, na raiz do projeto
├── create-crater-env.sh     ← (se estiver usando o script .env)
├── php-apache/
│   └── Dockerfile
├── node-api/
│   └── Dockerfile
├── laravel/
│   └── (seu projeto Laravel)
├── crater/
│   └── (código do Crater clonado)
├── node-scripts/
│   └── index.js
├── monitoring/
│   ├── prometheus.yml
│   └── grafana-provisioning/
└── zabbix/
    └── env_vars.env

