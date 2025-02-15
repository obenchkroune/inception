FROM alpine:3.21

RUN apk update && apk add go

RUN go install github.com/mailhog/MailHog@latest && \
    cp /root/go/bin/MailHog /usr/local/bin/MailHog

COPY ./scripts/mailhog-entrypoint.sh /usr/local/bin/mailhog-entrypoint.sh

RUN chmod +x /usr/local/bin/mailhog-entrypoint.sh
    
ENTRYPOINT [ "mailhog-entrypoint.sh" ]

CMD [ "MailHog", "-auth-file=./.auth" ]