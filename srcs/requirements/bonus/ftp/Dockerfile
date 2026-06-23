FROM alpine:3.23


# RUN apk update and install dependencies
RUN apk --update --no-cache add vsftpd  \
    && mkdir -p /var/log/vsftpd 

COPY conf/vsftpd.conf /etc/vsftpd/vsftpd.conf

COPY tools/docker-entrypoint.sh /

RUN chmod +x /docker-entrypoint.sh 

EXPOSE 20-22 990 21100-21110 

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["vsftpd", "/etc/vsftpd/vsftpd.conf"]
