FROM debian:bullseye

RUN apt update && apt install -y nginx openssl

COPY ./tools/nginx-entrypoint.sh /usr/local/bin/nginx-entrypoint.sh

RUN chmod +x /usr/local/bin/nginx-entrypoint.sh

COPY ./conf/default.conf /etc/nginx/sites-available/default

RUN mkdir -p /var/obenchkr.42.fr/logs && \
    chown -R www-data /var/obenchkr.42.fr/logs && \
    mkdir -p /etc/nginx/ssl && chown -R www-data /etc/nginx/ssl

RUN openssl req -x509 -newkey rsa:4096 -nodes -days 365 \
    -keyout /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.crt \
    -subj "/C=MA/ST=Rhamna/L=Ben Guerir/O=1337/OU=IT/CN=obenchkr.42.fr"


ENTRYPOINT [ "nginx-entrypoint.sh" ]

CMD [ "nginx", "-g", "daemon off;" ]