FROM node:alpine

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json /usr/src/app/

RUN apk add --update \
    python \
    python-dev \
    py-pip \
    build-base

RUN npm install

# Bundle app source
COPY laravel-echo-server.json /usr/src/app/laravel-echo-server.json

RUN apk add openssl
RUN openssl dhparam -out /etc/ssl/private/dhparam.pem 2048
RUN openssl genrsa -out "/etc/ssl/private/default.key" 2048
RUN openssl req -new -key "/etc/ssl/private/default.key" -out "/etc/ssl/private/default.csr" -subj "/CN=default/O=default/C=UK"
RUN openssl x509 -req -days 3650 -in "/etc/ssl/private/default.csr" -signkey "/etc/ssl/private/default.key" -out "/etc/ssl/private/default.crt"

EXPOSE 3000
CMD [ "npm", "start" ]
