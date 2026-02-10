#!/bin/sh
set -e

DOMAINS="${DOMAINS:-}"

if [ -z "$DOMAINS" ]; then
  echo "No DOMAINS set, skipping dummy cert generation"
  exit 0
fi

DUMMY_BASE="/etc/letsencrypt/dummy/live"

for domain in $DOMAINS; do
  CERT_DIR="$DUMMY_BASE/$domain"

  if [ ! -f "$CERT_DIR/fullchain.pem" ]; then
    echo "Generating dummy certificate for $domain"

    mkdir -p "$CERT_DIR"

    openssl req -x509 -nodes -newkey rsa:2048 \
      -days 1 \
      -keyout "$CERT_DIR/privkey.pem" \
      -out "$CERT_DIR/fullchain.pem" \
      -subj "/CN=$domain"
  fi
done
