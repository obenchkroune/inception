FROM alpine:3.21

RUN apk update && apk add nodejs npm

COPY ./app /app

WORKDIR /app

RUN npm install && npm run build

ENTRYPOINT [ "npm", "start" ]