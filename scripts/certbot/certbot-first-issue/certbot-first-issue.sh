#!/bin/sh
set -e

DOMAINS="$@"

if [ -z "$DOMAINS" ]; then
  echo "Error: DOMAINS required. Example: example.com www.example.com" >&2
  exit 1
fi

if [ -z "$LETSENCRYPT_EMAIL" ]; then
  echo "Error: missing required variable: LETSENCRYPT_EMAIL" >&2
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
