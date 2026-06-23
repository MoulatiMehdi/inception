FROM alpine:3.23

RUN apk update && apk add --no-cache nginx openssl envsubst 

COPY ./conf/nginx.conf /etc/nginx/nginx.conf.orig
COPY ./tools/docker-entrypoint.sh /

RUN chmod +x /docker-entrypoint.sh 

EXPOSE 443

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["nginx","-g","daemon off;"]

