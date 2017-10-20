FROM python:3.6-alpine 

RUN apk add --no-cache tini
RUN apk add --no-cache --virtual .build-deps libffi-dev openssl-dev build-base
RUN pip install errbot
RUN apk del .build-deps

RUN adduser -D -u 1000 errbot
USER errbot
WORKDIR /home/errbot

RUN errbot --init

ENTRYPOINT ["/sbin/tini", "--", "errbot"]