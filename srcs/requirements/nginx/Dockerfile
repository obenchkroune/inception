FROM debian:bullseye

RUN apt update && apt install -y nginx

COPY ./tools/nginx-entrypoint.sh /usr/local/bin/nginx-entrypoint.sh

RUN chmod +x /usr/local/bin/nginx-entrypoint.sh

COPY ./conf/default.conf /etc/nginx/sites-available/default

ENTRYPOINT [ "nginx-entrypoint.sh" ]

CMD [ "nginx", "-g", "daemon off;" ]

