#!/bin/sh
set -e

CERT_SAN="$1"

if [ -z "$CERT_SAN" ]; then
    echo "Error: CERT_SAN is required (Example: CERT_SAN=\"example.com www.example.com api.example.com\")" >&2
    exit 1
fi

DOMAIN="$(echo "$CERT_SAN" | awk '{print $1}')"

echo "Primary domain: $DOMAIN"
echo "Subject Alternative Names: $CERT_SAN"

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
  "$@"

echo "Certificate issued successfully"
