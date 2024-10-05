FROM alpine:3.20

RUN apk update && apk add nginx

COPY ./tools/default.conf /etc/nginx/http.d/

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
