#!/bin/bash
set -e

CONFIG_FILE="/var/www/html/config/config.inc.php"
TEMPLATE_FILE="/var/www/html/config/config.inc.php.template"

# Generate config.inc.php if missing or empty
if [ ! -s "$CONFIG_FILE" ]; then
    echo "Generating config.inc.php from template..."
    if [ -f "$TEMPLATE_FILE" ]; then
        envsubst < "$TEMPLATE_FILE" > "$CONFIG_FILE"
        chown www-data:www-data "$CONFIG_FILE"
    else
        echo "ERROR: Template file not found at $TEMPLATE_FILE!"
        exit 1
    fi
else
    echo "Using existing config.inc.php"
fi

# Ensure writable folders exist
echo "Ensuring cache, public, and files directories exist and have correct permissions..."
mkdir -p /var/www/html/cache/t_cache /var/www/html/cache/t_compile /var/www/html/cache/_db /var/www/files
chown -R www-data:www-data /var/www/html/cache /var/www/html/public /var/www/files

# Wait for MariaDB to be ready
echo "Waiting for MariaDB to be ready..."
until mysqladmin ping -h"${DB_HOST}" --silent; do
    echo "Waiting for database..."
    sleep 2
done
echo "MariaDB is ready!"

# Start Apache normally
echo "Starting Apache..."
exec apache2-foreground
