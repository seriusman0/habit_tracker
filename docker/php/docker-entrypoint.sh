#!/bin/sh
set -e

if [ -n "$DB_HOST" ]; then
  echo "Waiting for MySQL at $DB_HOST:${DB_PORT:-3306}..."
  until php -r "new PDO('mysql:host=$DB_HOST;port=${DB_PORT:-3306}', getenv('DB_USERNAME'), getenv('DB_PASSWORD'));" 2>/dev/null; do
    sleep 1
  done
  echo "MySQL is up."
fi

chown -R www-data:www-data storage bootstrap/cache 2>/dev/null || true

# bootstrap/cache lives on a container-only volume, decoupled from the host
# repo (which may have dev-only packages like laravel/pail installed for
# local tooling). Always regenerate it here from this container's own
# --no-dev vendor so a stale/foreign package manifest can never leak in.
rm -f bootstrap/cache/packages.php bootstrap/cache/services.php bootstrap/cache/events.php
php artisan package:discover --ansi || true

# Sync fresh build assets into the public/build volume
if [ -d /opt/build-assets ]; then
  cp -rf /opt/build-assets/. /var/www/html/public/build/ 2>/dev/null || true
  chown -R www-data:www-data /var/www/html/public/build 2>/dev/null || true
fi

exec "$@"
