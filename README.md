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
