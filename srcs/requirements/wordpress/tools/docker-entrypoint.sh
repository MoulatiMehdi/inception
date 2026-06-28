#!/bin/sh

set -eu

WP_URL="$DOMAIN_NAME"
WP_PATH="/var/www/html/"
WP_TITLE="My Wordpress"
WP_DB_HOST="mariadb"

REDIS_HOST="redis"
REDIS_PORT="6379"

# Create wp-config.php if not exists

if [ ! -f $WP_PATH/wp-config.php ]; then
    echo "Create wp-config.php"
    wp --path="$WP_PATH" config create \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_USER_PASSWORD" \
        --dbhost="$WP_DB_HOST" \
        --skip-check >/dev/null

    #wp config set WP_HOST "https://$DOMAIN_NAME" --allow-root
    #wp config set WP_SITEURL "https://$DOMAIN_NAME" --allow-root

    echo "Adding redis env variables..."
    wp --path=$WP_PATH config set FORCE_SSL_ADMIN 'false' --allow-root
    wp config set WP_REDIS_HOST "$REDIS_HOST" --allow-root
    wp config set WP_REDIS_PORT "$REDIS_PORT" --allow-root
    wp config set WP_CACHE 'true' --allow-root

    echo "Running Wordpress Installation... "
    wp --path=$WP_PATH core install \
        --url="$WP_URL" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_MAIL" \
        --allow-root

    wp user create $WP_USER $WP_USER_MAIL --user_pass=$WP_USER_PASSWORD --role='author' --allow-root

    echo "Installing Redis-Cache plugin..."
    wp --path=$WP_PATH plugin install redis-cache --allow-root
    wp --path=$WP_PATH plugin activate redis-cache --allow-root
    wp --path=$WP_PATH redis enable --allow-root
fi
exec "$@"
