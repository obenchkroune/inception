FROM debian:bullseye

RUN apt update && apt -y install curl php-fpm php mariadb-client php-mysqli php-mbstring php-pdo php-curl sendmail

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \ 
    chmod +x wp-cli.phar && \ 
    mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/wp-entrypoint.sh /usr/local/bin/wp-entrypoint.sh

RUN chmod +x /usr/local/bin/wp-entrypoint.sh

RUN mkdir -p /run/php && \
    chown -R www-data /run/php && \
    sed -i 's|^listen = .*|listen = 9000|g' /etc/php/7.4/fpm/pool.d/www.conf

VOLUME [ "/var/www/wordpress" ]

ENTRYPOINT [ "wp-entrypoint.sh" ]

CMD [ "php-fpm7.4", "-F" ]