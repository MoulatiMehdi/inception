#!/bin/sh
set -eu

MARIADB_PID=""
DATADIR="/var/lib/mysql"
SOCKET="/run/mysqld/mysqld.sock"

mariadb_log() {
    type="$1"
    shift
    printf '[%s] : %s\n' "$type" "$*"
}

mariadb_note() {
    mariadb_log "Note" "$*"
}

mariadb_error() {
    mariadb_log "Error" "$*" >&2
}

mariadb_temp_start() {
    mariadbd --skip-networking --socket="$SOCKET" --wsrep_on=OFF \
        --expire-logs-days=0 \
        --skip-slave-start \
        --loose-innodb_buffer_loop_load_at_startup=0 \
        --user=mysql \
        --skip-ssl --ssl-cert='' --ssl-key='' --ssl-ca='' \
        &
    MARIADB_PID=$!
    i=0
    while [ "$i" -le 30 ]; do
        echo "Waiting for MariaDB... attempt $i"
        if echo "SELECT 1" | mariadb --protocol=socket -uroot -hlocalhost --socket="$SOCKET" --skip-ssl --skip-ssl-verify-server-cert; then
            return 0
        fi
        sleep 1
        i=$((i + 1))
    done

    mariadb_error "unable to start the temporary server."
    return 1
}

mariadb_setup_directory() {

    mariadb_note "Creating mariadb Directories..."
    mkdir -p "$DATADIR"
    chown -R mysql: /var/lib/mysql /run/mysqld
    mariadb_note "mariadb Directories Created ."
}

mariadb_setup_db() {

    mariadb --protocol=socket -uroot -hlocalhost --database=mysql --socket="$SOCKET" --binary-mode --skip-ssl --skip-ssl-verify-server-cert <<EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

}

mariadb_init() {

    mariadb_note "Initializing  mariadb Databse files..."
    mariadb-install-db \
        --cross-bootstrap \
        --skip-test-db \
        --skip-log-bin \
        --expire-logs-days=0 \
        --loose-innodb_buffer_pool_load_at_startup=0 \
        --loose-innodb_buffer_pool_dump_at_shutdown=0
    mariadb_note "Database files initialized."

    mariadb_note "Starting Temporary Server..."
    mariadb_temp_start
    mariadb_note "Temporary Server Started."

    mariadb_note "Initializing  Databases..."
    mariadb_setup_db
    mariadb_note "Databases Initialized..."

    mariadb_note "Stopping Temporary Server..."
    mariadb_temp_stop
    mariadb_note "Temporary Server Stopped."
}

mariadb_temp_stop() {
    if [ -n "${MARIADB_PID:-}" ]; then
        kill "$MARIADB_PID" 2>/dev/null || true
        wait "$MARIADB_PID" 2>/dev/null || true
    fi
}

#  main code
mariadb_setup_directory
if [ ! -d "$DATADIR/mysql" ] || [ ! -f "$DATADIR/ibdata1" ]; then
    mariadb_init
fi

exec "$@"
