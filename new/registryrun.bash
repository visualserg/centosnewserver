#!/usr/bin/env bash

DOMAIN=""
LOGIN=""
PASS=""

## Generate Password for Basic Auth
mkdir auth
docker run \
  --entrypoint htpasswd \
  registry:2 -Bbn $LOGIN $PASS > auth/htpasswd

# https://docs.docker.com/registry/deploying/
docker run -d -p 443:5000 --restart=always --name registry \
  -v /etc/letsencrypt/live/$DOMAIN:/certs \
  -v /opt/docker-registry:/var/lib/registry \
  -v `pwd`/auth:/auth \
  -e "REGISTRY_AUTH=htpasswd" \
  -e "REGISTRY_AUTH_HTPASSWD_REALM=Axway Docker Registry" \
  -e REGISTRY_AUTH_HTPASSWD_PATH=./auth/htpasswd \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=./certs/domain.crt \
  -e REGISTRY_HTTP_TLS_KEY=./certs/domain.key \
  registry:2

