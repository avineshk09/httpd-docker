FROM alpine:3.7

RUN apk --update add build-base linux-headers libffi-dev curl perl gcc libressl-dev musl-dev libc-dev

RUN mkdir -p /opt/httpd_alpine
COPY scripts /opt/httpd_alpine/scripts

WORKDIR /opt/httpd_alpine
RUN chmod -R +x scripts

RUN scripts/provision.sh /opt/httpd_alpine

EXPOSE 1200-1250

COPY certs/server.crt /usr/local/apache2/conf/server.crt
COPY certs/server.key /usr/local/apache2/conf/server.key

COPY certs /opt/httpd_alpine/certs
COPY extra-ssl-hosts.conf /opt/httpd_alpine
RUN scripts/add_ssl_hosts.sh /opt/httpd_alpine

CMD ["/opt/httpd_alpine/scripts/bootstrap.sh", "-d"]
