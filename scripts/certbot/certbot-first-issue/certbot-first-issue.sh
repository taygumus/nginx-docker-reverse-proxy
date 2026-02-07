#!/bin/sh
set -e

DOMAINS="$@"

if [ -z "$DOMAINS" ]; then
  echo "Usage: certbot-first-issue <domain1> [domain2 ...]"
  exit 1
fi

if [ -z "$LETSENCRYPT_EMAIL" ]; then
  echo "LETSENCRYPT_EMAIL is required"
  exit 1
fi

echo "Requesting certificate for: $DOMAINS"

certbot certonly \
  --webroot \
  --webroot-path /var/www/certbot \
  --email "$LETSENCRYPT_EMAIL" \
  --agree-tos \
  --no-eff-email \
  --non-interactive \
  $(for d in $DOMAINS; do printf -- "-d %s " "$d"; done)

echo "Certificate issued successfully"
