#!/bin/sh
set -e

CERT_SAN="$1"

if [ -z "$CERT_SAN" ]; then
  echo "Error: CERT_SAN is required" >&2
  echo "Example: CERT_SAN=\"example.com www.example.com api.example.com\"" >&2
  exit 1
fi

: "${LETSENCRYPT_EMAIL:?LETSENCRYPT_EMAIL must be set}"

DOMAIN="$(echo "$CERT_SAN" | awk '{print $1}')"

echo "Primary domain: $DOMAIN"
echo "Subject Alternative Names: $CERT_SAN"

TARGET_DIR="/etc/letsencrypt/live/$DOMAIN"
RENEWAL_CONF="/etc/letsencrypt/renewal/$DOMAIN.conf"

if [ -d "$TARGET_DIR" ] && [ ! -f "$RENEWAL_CONF" ]; then
  echo "Dummy certificate detected for $DOMAIN, removing it..."
  rm -rf "$TARGET_DIR"
fi

set --
for name in $CERT_SAN; do
  set -- "$@" -d "$name"
done

exec certbot certonly \
  --webroot \
  --webroot-path /var/www/certbot \
  --email "$LETSENCRYPT_EMAIL" \
  --agree-tos \
  --no-eff-email \
  --non-interactive \
  --cert-name "$DOMAIN" \
  "$@"
