#!/bin/sh

# Substituir variáveis de ambiente no index.html se necessário
if [ -n "$VITE_EVOLUTION_API_URL" ]; then
    sed -i "s|VITE_EVOLUTION_API_URL|$VITE_EVOLUTION_API_URL|g" /usr/share/nginx/html/index.html
fi

# Iniciar nginx
exec nginx -g "daemon off;"
