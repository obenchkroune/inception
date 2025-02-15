FROM alpine:3.21

RUN apk update && apk add go

RUN go install github.com/mailhog/MailHog@latest && \
    cp /root/go/bin/MailHog /usr/local/bin/MailHog

EXPOSE 8025
    
ENTRYPOINT [ "MailHog" ]