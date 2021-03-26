# radsoc

Project for build docker images and running services - uses docker-compose

## Project setup

To build / pull images

```bash
docker-compose build --pull --force-rm
```

```bash
docker tag radsoc_assets mijoco/radsoc_assets
docker tag radsoc_lsat mijoco/radsoc_lsat
docker tag radsoc_mesh mijoco/radsoc_mesh
docker push mijoco/radsoc_assets
docker push mijoco/radsoc_lsat
docker push mijoco/radsoc_mesh
```

Run the containers

```bash
docker-compose up -d
```

## Curl Testing

```bash
$ curl -d '{"assetHash":"title of ticket", "paymentId":"product.id", "purchaseDate":"2020-03-01", "amount":"10.50", "addressTo":"unknown", "addressFrom":"unknown"}' -H "Content-Type: application/json" -L --verbose -X POST http://localhost:8042/assets/buy-now
```

```bash
$ curl -d '{"sender":"ST3MMDYNCCSYKB9E77KD9QD8RG2QY72X6V444X0RX", "arguments":"[]"}' -H "Content-Type: application/json" -L --verbose -X POST https://stacks-node-api-latest.argon.blockstack.xyz/v2/contracts/call-read/ST3MMDYNCCSYKB9E77KD9QD8RG2QY72X6V444X0RX/loopbomb/get-base-token-uri
```

## SSL localhost

See: https://gist.github.com/cecilemuller/9492b848eb8fe46d462abeb26656c4f8

First create root CA

```bash
openssl req -x509 -nodes -new -sha256 -days 1024 -newkey rsa:2048 -keyout RadicleCA.key -out RadicleCA.pem -subj "/C=US/CN=Radicle-Root-CA"
openssl x509 -outform pem -in RadicleCA.pem -out RadicleCA.crt
```

Define the domains - requires customer domains to mimic actual deployment;

```bash
vi $PROJECT_ROOT/certs/domains.ext
```

create certificates - see domains.ext

```bash
openssl req -new -nodes -newkey rsa:2048 -keyout assets.key -out assets.csr -subj "/C=UK/ST=Sussex/L=Brighton/O=Radicle-Certs/CN=risidio.local"
openssl x509 -req -sha256 -days 1024 -in assets.csr -CA RadicleCA.pem -CAkey RadicleCA.key -CAcreateserial -extfile domains.ext -out assets.crt
```

Copy them into a volume nginx can access

```bash
cd $PROJECT_ROOT/certs

cp certs/assets.key certs/assets.crt ./volumes/certbot/local/.
```

in the vhost file e.g. /etc/nginx/sites-enabled/risidio.local

```bash
server {
  server_name login.risidio.local;
  ssl_certificate /var/certbot/local/assets.crt;
  ssl_certificate_key /var/certbot/local/assets.key;
```

## certbot

Configuration care of;
[medium article](https://medium.com/@pentacent/nginx-and-lets-encrypt-with-docker-in-less-than-5-minutes-b4b8a60d3a71).
