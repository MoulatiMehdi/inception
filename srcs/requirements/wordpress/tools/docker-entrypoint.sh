#!/bin/sh

sed -ex

# Create wp-config.php if not exists
cp wp-config-sample.php wp-config.php

DB_NAME=${MYSQL_DATABASE}
DB_USER=${MYSQL_USER}
DB_PASSWORD=$(cat /run/secrets/db_password)

# Configure WordPress DB settings
sed -i -E "s/database_name_here/$DB_NAME/" wp-config.php
sed -i -E "s/username_here/$DB_USER/" wp-config.php
sed -i -E "s/password_here/$DB_PASSWORD/" wp-config.php
sed -i -E "s/localhost/mariadb/" wp-config.php

exec "$@"
