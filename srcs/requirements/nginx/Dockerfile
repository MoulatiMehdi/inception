FROM alpine:3.23

RUN apk add --no-cache nginx openssl envsubst 

COPY ./conf/nginx.conf /etc/nginx/nginx.conf.orig
COPY ./tools/docker-entrypoint.sh /

RUN chmod +x /docker-entrypoint.sh && mkdir -p /etc/nginx/ssl

EXPOSE 443

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["nginx","-g","daemon off;"]

