FROM alpine:3.23

ARG NAME=site 

RUN apk add --no-cache \
        npm 

ADD https://github.com/MoulatiMehdi/free-nextjs-admin-dashboard.git /$NAME

WORKDIR /$NAME

COPY tools/docker-entrypoint.sh /

RUN chmod +x /docker-entrypoint.sh

EXPOSE 3000

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["npm","next","start"]



