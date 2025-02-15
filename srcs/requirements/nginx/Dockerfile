FROM alpine:3.21

RUN apk update && apk add --no-cache nginx openssl

RUN rm /etc/nginx/http.d/default.conf
COPY ./conf/ /etc/nginx/http.d/

COPY ./scripts/nginx-entrypoint.sh /usr/local/bin/nginx-entrypoint.sh

RUN chmod +x /usr/local/bin/nginx-entrypoint.sh

ENTRYPOINT [ "nginx-entrypoint.sh" ]

CMD [ "nginx", "-g", "daemon off;" ]