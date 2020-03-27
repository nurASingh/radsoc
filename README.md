# af-mf-appshell

## Project setup

To build / pull images

```
docker-compose build --pull --force-rm
```

```
docker tag af-compose_assets mijoco/af-compose_assets
docker tag af-compose_clients mijoco/af-compose_clients
docker push mijoco/af-compose_assets
docker push mijoco/af-compose_clients
```

Run the containers

```
docker-compose up -d
```

## SSL localhost

See: https://gist.github.com/cecilemuller/9492b848eb8fe46d462abeb26656c4f8

First create root CA

```
openssl req -x509 -nodes -new -sha256 -days 1024 -newkey rsa:2048 -keyout RadicleCA.key -out RadicleCA.pem -subj "/C=US/CN=Radicle-Root-CA"
openssl x509 -outform pem -in RadicleCA.pem -out RadicleCA.crt
```

Define the domains - requires customer domains to mimic actual deployment;

```
vi $PROJECT_ROOT/certs/domains.ext
```

create certificates - see domains.ext

```
openssl req -new -nodes -newkey rsa:2048 -keyout assets.key -out assets.csr -subj "/C=UK/ST=Sussex/L=Brighton/O=Radicle-Certs/CN=assets.local"
openssl x509 -req -sha256 -days 1024 -in assets.csr -CA RadicleCA.pem -CAkey RadicleCA.key -CAcreateserial -extfile domains.ext -out assets.crt
```

Copy them into a volume nginx can access

```
cp assets.key assets.crt $PROJECT_ROOT/volumes/certbot/local/.
```

in the vhost file e.g. /etc/nginx/sites-enabled/assets.local

```
server {
	server_name *-login.assets.local;
  .
  .
	ssl_certificate /var/certbot/local/assets.crt;
	ssl_certificate_key /var/certbot/local/assets.key;
```

## certbot

Configuration care of;
[medium article](https://medium.com/@pentacent/nginx-and-lets-encrypt-with-docker-in-less-than-5-minutes-b4b8a60d3a71).