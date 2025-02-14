FROM alpine:3.21

RUN apk update && apk add --no-cache php php-fpm php-mysqli php-openssl php-session curl php-pcntl

RUN mkdir -p /var/www/adminer

COPY ./scripts/adminer-entrypoint.sh /usr/local/bin/adminer-entrypoint.sh
RUN chmod +x /usr/local/bin/adminer-entrypoint.sh

RUN sed -i -E 's/^[[:space:]]*;?[[:space:]]*listen = .*/listen = 9001/g' /etc/php83/php-fpm.d/www.conf

WORKDIR /var/www/adminer

RUN curl -L -o index.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php

VOLUME [ "/var/www/adminer" ]

ENTRYPOINT [ "adminer-entrypoint.sh" ]

CMD [ "php-fpm83", "-F" ]