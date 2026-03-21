#!/bin/sh
set -e

MARKER_FILE="${RELOAD_MARKER_FILE:-/var/www/certbot/.nginx-reload}"
POLL_INTERVAL="${RELOAD_POLL_INTERVAL:-10}"

MARKER_DIR="$(dirname "$MARKER_FILE")"

if [ -d "$MARKER_DIR" ]; then
  echo "Starting nginx reload watcher (marker: $MARKER_FILE, interval: ${POLL_INTERVAL}s)"
  (
    set +e

    while true; do
      if [ -f "$MARKER_FILE" ]; then
        if nginx -s reload >/dev/null 2>&1; then
          rm -f "$MARKER_FILE"
          echo "Nginx reloaded (marker consumed)"
        else
          echo "Nginx reload requested but failed; will retry"
        fi
      fi

      sleep "$POLL_INTERVAL"
    done
  ) &
else
  echo "Reload watcher skipped: $MARKER_DIR not found"
fi
