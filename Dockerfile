FROM alpine:3.19

RUN apk add --no-cache pipx openssh-client
RUN apk add --no-cache --virtual .build-dependencies build-base py3-cffi python3-dev libffi-dev openssl-dev

ENV ANSIBLE_VERSION 2.16.6
ENV PIPX_BIN_DIR /usr/local/bin

RUN pipx install ansible-core==$ANSIBLE_VERSION
RUN pipx install ansible-lint

RUN apk del .build-dependencies && rm -rf /var/cache/apk/*
RUN find /usr/lib -name "*.pyc" -or -name "__pycache__" -exec rm {} -rf +

RUN mkdir -p /etc/ansible
COPY ansible.cfg /etc/ansible/ansible.cfg
COPY requirements.yml .
RUN ansible-galaxy install -r requirements.yml

WORKDIR /app
