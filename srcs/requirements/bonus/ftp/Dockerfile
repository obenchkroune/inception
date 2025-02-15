FROM alpine:3.21

RUN apk update && apk add --no-cache vsftpd openssl

COPY ./scripts/ftp-entrypoint.sh /usr/local/bin/ftp-entrypoint.sh

COPY ./conf/vsftpd.conf /etc/vsftpd/vsftpd.conf

RUN chmod +x /usr/local/bin/ftp-entrypoint.sh

EXPOSE 21
EXPOSE 20
EXPOSE 21000-21010

VOLUME [ "/var/www/wordpress" ]

ENTRYPOINT [ "ftp-entrypoint.sh" ]

CMD [ "vsftpd", "/etc/vsftpd/vsftpd.conf" ]