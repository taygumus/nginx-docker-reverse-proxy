#!/bin/sh
set -e

. /scripts/utils/check-required-vars.sh

check_required_vars "DOMAINS LETSENCRYPT_EMAIL"

echo "Requesting certificate for domains: $DOMAINS"

DOMAIN_ARGS=""
for d in $DOMAINS; do
  DOMAIN_ARGS="$DOMAIN_ARGS -d $d"
done

certbot certonly \
  --webroot \
  --webroot-path /var/www/certbot \
  --email "$LETSENCRYPT_EMAIL" \
  --agree-tos \
  --no-eff-email \
  --non-interactive \
  $DOMAIN_ARGS

echo "Certificate issued successfully"
