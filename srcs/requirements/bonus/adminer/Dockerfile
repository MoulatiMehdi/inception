FROM alpine:3.23

ARG VERSION=5.4.2

RUN apk add --no-cache \
        php83 \
        php83-mysqli \ 
        php83-session \
    && mkdir -p /var/www/html/ \
    && wget -O /var/www/html/index.php https://github.com/vrana/adminer/releases/download/v${VERSION}/adminer-${VERSION}.php 

EXPOSE 8081

CMD ["php83", "-S", "0.0.0.0:8081", "-t", "/var/www/html"]
