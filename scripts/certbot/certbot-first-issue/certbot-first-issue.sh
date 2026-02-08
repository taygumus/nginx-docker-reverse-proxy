#!/bin/sh
set -e

. /scripts/utils/check-required-vars.sh

check_required_vars "DOMAINS LETSENCRYPT_EMAIL"

echo "Requesting certificate for domains: $DOMAINS"

CERTBOT_DOMAINS=""

for d in $DOMAINS; do
  CERTBOT_DOMAINS="$CERTBOT_DOMAINS -d $d"
done

certbot certonly \
  --webroot \
  --webroot-path /var/www/certbot \
  --email "$LETSENCRYPT_EMAIL" \
  --agree-tos \
  --no-eff-email \
  --non-interactive \
  $CERTBOT_DOMAINS

echo "Certificate issued successfully"
