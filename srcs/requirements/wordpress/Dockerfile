FROM alpine:3.23

ARG WP_VERSION=7.0

RUN apk add --no-cache \
    php83 \
    php83-fpm \
    php83-mysqli \
    php83-zip \
    php83-curl \
    php83-phar \
    php83-tokenizer \
    php83-mbstring \
    php83-opcache \
    php83-pecl-redis \
    php83-ctype \
    php83-xml 

WORKDIR /var/www/html 

# Setup Wordpress
RUN wget -O /var/www/html/wp.tar.gz https://wordpress.org/wordpress-${WP_VERSION}.tar.gz \
    && tar -xzf wp.tar.gz \
    && rm wp.tar.gz \
    && mv wordpress/* . \
    && rmdir wordpress  \
    && chown -R nobody:nobody /var/www/html \
    && chmod -R 775 /var/www/html/wp-content 

# Setup php-fpm 
RUN sed -i 's|listen = 127.0.0.1:9000|listen = 9000|' /etc/php83/php-fpm.d/www.conf\
    && mkdir -p /run/php \ 
    && ln -s /usr/bin/php83 /usr/bin/php 

# Setup wp-cli
RUN wget -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp 

COPY ./tools/docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh 

EXPOSE 9000

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["php-fpm83","-F"]
