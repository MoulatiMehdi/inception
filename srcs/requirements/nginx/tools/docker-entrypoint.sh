#!/bin/sh

set -eu
mkdir -p /etc/nginx/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/tls.key \
    -out /etc/nginx/ssl/tls.crt \
    -quiet \
    -subj "/C=MA/ST=MS/L=BenGuerir/O=42/OU=Inception/CN=$DOMAIN_NAME" >/dev/null

envsubst '$DOMAIN_NAME' </etc/nginx/nginx.conf.orig >/etc/nginx/nginx.conf

echo "Running nginx ..."
exec "$@"
