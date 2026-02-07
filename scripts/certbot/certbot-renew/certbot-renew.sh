#!/bin/sh
set -e

. /scripts/certbot/certbot-renew/lib/terminate.sh

trap terminate TERM INT

echo "Certbot renewal service started"
echo "Renewal interval: ${CERTBOT_RENEW_INTERVAL}"

while true; do
  echo "Checking certificates"

  if certbot renew --webroot -w /var/www/certbot --quiet; then
    echo "Renewal check completed"
  else
    echo "Renewal check returned non-zero status (may be expected)"
  fi

  echo "Waiting ${CERTBOT_RENEW_INTERVAL} for next check..."
  sleep "${CERTBOT_RENEW_INTERVAL}"
done
