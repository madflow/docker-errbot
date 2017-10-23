FROM python:3.6-alpine 

RUN apk add --no-cache git tini
RUN apk add --no-cache --virtual .build-deps libffi-dev openssl-dev build-base
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
RUN apk del .build-deps

RUN adduser -D -u 1000 errbot
USER errbot
WORKDIR /home/errbot

RUN errbot --init

ONBUILD USER root
ONBUILD COPY requirements.txt requirements.txt
ONBUILD RUN pip install -r requirements.txt
ONBUILD USER errbot

ENTRYPOINT ["/sbin/tini", "--", "errbot"]
