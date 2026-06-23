FROM alpine:3.23

RUN apk add --no-cache wget ca-certificates 

# Download cAdvisor binary 
RUN wget -O /usr/bin/cadvisor https://github.com/google/cadvisor/releases/download/v0.57.0/cadvisor-v0.57.0-linux-amd64 

RUN chmod +x /usr/bin/cadvisor

EXPOSE 8080

CMD ["/usr/bin/cadvisor"]
