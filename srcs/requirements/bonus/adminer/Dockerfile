FROM alpine:3.21

RUN apk update && apk add --no-cache php php-fpm php-mysqli php-openssl php-session curl

RUN mkdir -p /var/www/adminer

WORKDIR /var/www/adminer

RUN curl -L -o index.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php

ENTRYPOINT ["php", "-S", "0.0.0.0:9001", "-t", "/var/www/adminer"]