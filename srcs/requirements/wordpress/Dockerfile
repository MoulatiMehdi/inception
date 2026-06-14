FROM alpine:3.23

RUN apk update && apk add --no-cache \
    php83 \
    php83-fpm \
    php83-mysqli \
    php83-zip \
    php83-curl \
    php83-mbstring \
    php83-opcache \
    php83-xml 


# Set working directory

WORKDIR /var/www/html 

# Download WordPress
RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz \
    && rm latest.tar.gz \
    && mv wordpress/* . \
    && rmdir wordpress  \
    && chmod -R 1777 /var/www/html/wp-content \
    && sed -i 's|listen = 127.0.0.1:9000|listen = 9000|' /etc/php83/php-fpm.d/www.conf\ 
    && mkdir -p /run/php 

COPY ./tools/docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh 

EXPOSE 9000

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["php-fpm83","-F"]
