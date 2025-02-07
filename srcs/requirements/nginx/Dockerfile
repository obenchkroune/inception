FROM debian:bullseye

RUN apt update && apt install -y nginx

COPY ./tools/nginx-entrypoint.sh /usr/local/bin/

# TODO: implement the nginx image requirements

ENTRYPOINT [ "nginx-entrypoint.sh" ]

CMD [ "nginx", "-g", "daemon off;" ]

