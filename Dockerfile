FROM alpine:3.19

RUN apk add --no-cache pipx openssh-client

ENV ANSIBLE_VERSION 2.16.6
ENV PIPX_BIN_DIR /usr/local/bin

RUN pipx install ansible-core==$ANSIBLE_VERSION

RUN mkdir -p /etc/ansible
COPY ansible.cfg /etc/ansible/ansible.cfg
RUN ansible-galaxy collection install community.general

WORKDIR /app
