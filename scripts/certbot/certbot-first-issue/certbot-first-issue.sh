#!/bin/sh
set -e

CERT_SAN="$1"

if [ -z "$CERT_SAN" ]; then
    echo "Error: CERT_SAN is required (Example: CERT_SAN=\"example.com www.example.com api.example.com\")" >&2
    exit 1
fi

PRIMARY_DOMAIN="$(echo "$CERT_SAN" | awk '{print $1}')"

echo "Primary domain: $PRIMARY_DOMAIN"
echo "Subject Alternative Names: $CERT_SAN"

if certbot certificates 2>/dev/null | grep -q "Certificate Name: $PRIMARY_DOMAIN"; then
  echo "A valid certificate already exists for $PRIMARY_DOMAIN"
  echo "Nothing to do."
  exit 0
fi

echo "Requesting initial certificate for $PRIMARY_DOMAIN"

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
