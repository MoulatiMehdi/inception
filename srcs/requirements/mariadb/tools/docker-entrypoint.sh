#!/bin/sh
set -eu

DATA_DIR="/var/lib/mysql"
MYSQL_PASSWORD="$(cat /run/secrets/db_password)"
MYSQL_ROOT_PASSWORD="$(cat /run/secrets/db_root_password)"

echo "[INIT] Initializing MariaDB..."

# Fail fast if missing critical secrets
if [ -z "$MYSQL_ROOT_PASSWORD" ] || [ -z "$MYSQL_PASSWORD" ]; then
    echo "ERROR: Missing required database passwords" >&2
    exit 1
fi

# Run init SQL only if this is the first boot
if [ ! -f "$DATA_DIR/.bootstrapped" ]; then
  mariadbd --skip-networking --user=mysql &
  PID=$!
  # Wait for socket to be ready
  until mariadb-admin ping --silent; do sleep 1; done

  mariadb -u root << EOF 
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;

CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';

GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';

ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

FLUSH PRIVILEGES;
EOF
  touch "$DATA_DIR/.bootstrapped"
  kill $PID
  wait $PID
fi

unset MYSQL_PASSWORD 
unset MYSQL_ROOT_PASSWORD

exec "$@"
