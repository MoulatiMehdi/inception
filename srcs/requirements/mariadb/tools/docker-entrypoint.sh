#!/bin/sh
set -eu

DATA_DIR="/var/lib/mysql"
chown -R mysql:mysql /var/lib/mysql /run/mysqld

echo "[INIT] Initializing MariaDB..."
if [ ! -f "$DATA_DIR/.bootstrapped" ]; then

    mariadbd --skip-networking --user=mysql &
    PID=$!
    # Wait for socket to be ready
    until mariadb-admin ping --silent; do sleep 1; done

    mariadb -u root <<EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

    touch "$DATA_DIR/.bootstrapped"
    kill "$PID"
fi

exec "$@"
