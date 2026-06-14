FROM alpine:3.23


RUN  apk update  \
    && apk add mariadb envsubst mariadb-client\
    && mkdir -p /var/lib/mysql /run/mysqld \
    && chmod 1777 /run/mysqld \ 
    && mariadb-install-db --user=mysql --datadir=/var/lib/mysql  \
    && chown -R mysql:mysql /var/lib/mysql /run/mysqld

COPY ./tools/docker-entrypoint.sh /docker-entrypoint.sh
COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

RUN chmod +x /docker-entrypoint.sh  


EXPOSE 3306

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["mariadbd"]
