#!/bin/sh
set -e

DOMAINS="${DOMAINS:-}"

if [ -z "$DOMAINS" ]; then
  echo "No DOMAINS set, skipping dummy cert linking"
  exit 0
fi

LE_BASE="/etc/letsencrypt"

for domain in $DOMAINS; do
  TARGET_DIR="$LE_BASE/live/$domain"
  DUMMY_DIR="$LE_BASE/dummy/live/$domain"

  if [ ! -f "$TARGET_DIR/fullchain.pem" ]; then
    echo "Creating symlink for $domain: $DUMMY_DIR -> $TARGET_DIR"

    mkdir -p "$TARGET_DIR"

    ln -sf "$DUMMY_DIR/fullchain.pem" "$TARGET_DIR/fullchain.pem"
    ln -sf "$DUMMY_DIR/privkey.pem" "$TARGET_DIR/privkey.pem"
  else
    echo "Certificate or link already exists for $domain, skipping"
  fi
done
