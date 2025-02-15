FROM alpine:3.21

RUN apk update && apk add --no-cache redis

COPY ./scripts/redis-entrypoint.sh /usr/local/bin/redis-entrypoint.sh

COPY ./conf/redis.conf /etc/redis.conf

RUN chmod +x /usr/local/bin/redis-entrypoint.sh

WORKDIR /var/lib/redis

ENTRYPOINT [ "redis-entrypoint.sh" ]

CMD [ "redis-server", "/etc/redis.conf" ]