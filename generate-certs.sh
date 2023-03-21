#!/bin/bash

### GUIA DE APPSEC :: MUTUAL TLS ###

if [ ! -d "certs" ]; then
    mkdir "certs"
fi

BYTES=4096

openssl req -new -newkey rsa:$BYTES \
    -sha256 -nodes \
    -keyout certs/server.key \
    -out certs/server.csr \
    -subj "/CN=localhost"


openssl req -new -newkey rsa:$BYTES \
    -sha256 -nodes \
    -keyout certs/client.key \
    -out certs/client.csr \
    -subj "/CN=localhost"

openssl genrsa -out certs/ca.key $BYTES
openssl req -new -x509 -key certs/ca.key -out certs/ca.crt

echo "[server]
subjectAltName = DNS:localhost,IP:127.0.0.1" > certs/server.ext

echo "[client]
subjectAltName = DNS:localhost,IP:127.0.0.1" > certs/client.ext


openssl x509 -req -in certs/server.csr \
    -CA certs/ca.crt -CAkey certs/ca.key -CAcreateserial \
    -out certs/server.crt -days 365 -sha256 \
    -extfile certs/server.ext -extensions server

openssl x509 -req -in certs/client.csr \
    -CA certs/ca.crt -CAkey certs/ca.key -CAcreateserial \
    -out certs/client.crt -days 365 -sha256 \
    -extfile certs/client.ext -extensions client

