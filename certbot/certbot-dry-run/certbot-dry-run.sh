#!/bin/sh
set -e

echo "Running Certbot dry-run (renew simulation)"

certbot renew --dry-run

echo "Dry-run completed successfully"
