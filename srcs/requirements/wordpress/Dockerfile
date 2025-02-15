FROM alpine:3.21

RUN apk update && apk add --no-cache curl php \
    php-fpm php-phar php-pdo php-xml php-mbstring \
    php-mysqli php-curl php-redis php-tokenizer \
    php-ctype php-ftp php-zip netcat-openbsd

COPY ./conf/www.conf /etc/php83/php-fpm.d/www.conf
COPY ./conf/php.ini /etc/php83/php.ini

WORKDIR /var/www/wordpress

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \ 
    chmod +x wp-cli.phar && \ 
    mv wp-cli.phar /usr/local/bin/wp

RUN php -d memory_limit=512M "$(which wp)" core download --allow-root

COPY ./scripts/wp-entrypoint.sh /usr/local/bin/wp-entrypoint.sh
RUN chmod +x /usr/local/bin/wp-entrypoint.sh

VOLUME [ "/var/www/wordpress" ]

ENTRYPOINT [ "wp-entrypoint.sh" ]

CMD [ "php-fpm83", "-F" ]