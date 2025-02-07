FROM alpine:3.20

RUN apk update && apk add --no-cache curl php-fpm php php-phar php-curl php-mysqli php-pdo php-mbstring mariadb-client

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \ 
    chmod +x wp-cli.phar && \ 
    mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/wp-entrypoint.sh /usr/local/bin/wp-entrypoint.sh

RUN chmod +x /usr/local/bin/wp-entrypoint.sh

VOLUME [ "/var/www" ]

ENTRYPOINT [ "wp-entrypoint.sh" ]