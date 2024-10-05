FROM alpine:3.20

RUN apk update && apk add php php-fpm php-mysqli php-json php-session php-curl php-phar php-xml curl netcat-openbsd php-tokenizer php-mbstring

RUN sed -i 's/^listen = .*/listen = 9000/' /etc/php83/php-fpm.d/www.conf && \
    mkdir -p /var/www/html

WORKDIR /var/www/html

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/init_wp.sh /usr/local/bin

RUN chmod +x /usr/local/bin/init_wp.sh
    
ENTRYPOINT [ "/usr/local/bin/init_wp.sh" ]
