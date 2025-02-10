FROM alpine:3.21

RUN apk update && apk add nginx openssl

COPY ./conf/default.conf /etc/nginx/http.d/default.conf

COPY ./conf/ssl /etc/nginx/ssl

RUN mkdir -p /var/obenchkr.42.fr/logs && \
    chown -R nginx /var/obenchkr.42.fr/logs && \
    mkdir -p /etc/nginx/ssl && chown -R nginx /etc/nginx/ssl

COPY ./tools/nginx-entrypoint.sh /usr/local/bin/nginx-entrypoint.sh
RUN chmod +x /usr/local/bin/nginx-entrypoint.sh

ENTRYPOINT [ "nginx-entrypoint.sh" ]

CMD [ "nginx", "-g", "daemon off;" ]