#!/bin/sh
set -e

. /scripts/utils/check-required-vars.sh

check_required_vars "SERVER_NAME LETSENCRYPT_EMAIL"

echo "Requesting first Let's Encrypt certificate for $SERVER_NAME"

certbot certonly \
  --webroot \
  --webroot-path /var/www/certbot \
  --domain "$SERVER_NAME" \
  --email "$LETSENCRYPT_EMAIL" \
  --agree-tos \
  --no-eff-email \
  --non-interactive

echo "Certificate successfully issued"
