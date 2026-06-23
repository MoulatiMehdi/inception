#!/bin/sh

# Define default values of Environment Variables
FTP_USER=${FTP_USER:-user}
FTP_PASSWORD=${FTP_PASSWORD:-user}
PASV_ENABLE=${PASV_ENABLE:-YES}
PASV_ADDR_RESOLVE=${PASV_ADDR_RESOLVE:-NO}
PASV_MIN_PORT=${PASV_MIN_PORT:-21100}
PASV_MAX_PORT=${PASV_MAX_PORT:-21110}
VSFTPD_CONF=/etc/vsftpd/vsftpd.conf

mkdir -p /var/lib/ftp/wp-content && chmod 777 /var/lib/ftp/wp-content 

# Add the FTP_USER, change his password and declare him as the owner of his home folder and all subfolders
addgroup -S $FTP_USER
adduser -D -G $FTP_USER -h /var/lib/ftp/wp-content -s /bin/false  $FTP_USER
echo "$FTP_USER:$FTP_PASSWORD" | /usr/sbin/chpasswd

# Building the configuration file
cat >> $VSFTPD_CONF << EOF 
# the following config lines are added by the run-vsftpd.sh script for passive mode

anonymous_enable=NO
pasv_enable=$PASV_ENABLE
pasv_address=$PASV_ADDRESS
pasv_addr_resolve=$PASV_ADDR_RESOLVE
pasv_max_port=$PASV_MAX_PORT
pasv_min_port=$PASV_MIN_PORT
EOF

# Run the vsftpd server
echo "Running vsftpd..."
exec "$@" 

