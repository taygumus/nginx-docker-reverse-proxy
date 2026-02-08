#!/bin/sh
set -e

. /scripts/utils/check-required-vars.sh

check_required_vars "DOMAINS LETSENCRYPT_EMAIL"

echo "Requesting certificate for domains: $DOMAINS"

certbot certonly \
  --webroot \
  --webroot-path /var/www/certbot \
  --email "$LETSENCRYPT_EMAIL" \
  --agree-tos \
  --no-eff-email \
  --non-interactive \
  $(for d in $DOMAINS; do printf -- "-d %s " "$d"; done)

echo "Certificate issued successfully"
