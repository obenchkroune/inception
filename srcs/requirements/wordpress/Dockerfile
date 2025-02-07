FROM debian:bullseye

RUN apt update && apt -y install curl php-fpm php mariadb-client php-mysqli php-mbstring php-pdo php-curl

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \ 
    chmod +x wp-cli.phar && \ 
    mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/wp-entrypoint.sh /usr/local/bin/wp-entrypoint.sh

RUN chmod +x /usr/local/bin/wp-entrypoint.sh

VOLUME [ "/var/www/wordpress" ]

ENTRYPOINT [ "wp-entrypoint.sh" ]