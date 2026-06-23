FROM alpine:3.23 

RUN apk add --no-cache redis  \
    && echo -e "\
    bind 0.0.0.0:6379\
    maxmemory 256mb\
    maxmemory-policy allkeys-lfu" >> /etc/redis.conf

EXPOSE 6379

CMD ["redis-server","--protected-mode","no"]
