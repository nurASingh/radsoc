#!/bin/bash -e
#
############################################################

export SERVICE=$1
export SERVER=hume.brightblock.org
export DOCKER_ID_USER='mijoco'
export DOCKER_COMPOSE_CMD='docker-compose'
export DOCKER_CMD='docker'

if [ "$SERVICE" == "all" ]; then
  mvn -f ../ms-assets/pom.xml -Dmaven.test.skip=true clean install
  mvn -f ../ms-lsat/pom.xml -Dmaven.test.skip=true clean install
  mvn -f ../ms-mesh/pom.xml -Dmaven.test.skip=true clean install
	docker-compose build
	$DOCKER_CMD tag mijoco/radsoc_assets mijoco/radsoc_assets
	$DOCKER_CMD tag mijoco/radsoc_lsat mijoco/radsoc_lsat
	$DOCKER_CMD tag mijoco/radsoc_mesh  mijoco/radsoc_mesh
	$DOCKER_CMD tag mijoco/radsoc_nginx mijoco/radsoc_nginx

	$DOCKER_CMD push mijoco/radsoc_assets:latest
	$DOCKER_CMD push mijoco/radsoc_lsat:latest
	$DOCKER_CMD push mijoco/radsoc_mesh:latest
	$DOCKER_CMD push mijoco/radsoc_nginx:latest
fi
if [ "$SERVICE" == "assets" ]; then
  mvn -f ../ms-assets/pom.xml -Dmaven.test.skip=true clean install
	docker-compose build assets
	$DOCKER_CMD tag mijoco/radsoc_assets mijoco/radsoc_assets
	$DOCKER_CMD push mijoco/radsoc_assets:latest
fi
if [ "$SERVICE" == "lsat" ]; then
  mvn -f ../ms-lsat/pom.xml -Dmaven.test.skip=true clean install
	docker-compose build
	$DOCKER_CMD tag mijoco/radsoc_lsat mijoco/radsoc_lsat
	$DOCKER_CMD push mijoco/radsoc_lsat:latest
fi
if [ "$SERVICE" == "mesh" ]; then
  mvn -f ../ms-mesh/pom.xml -Dmaven.test.skip=true clean install
	docker-compose build
	$DOCKER_CMD tag mijoco/radsoc_mesh  mijoco/radsoc_mesh
	$DOCKER_CMD push mijoco/radsoc_mesh:latest
fi
if [ "$SERVICE" == "nginx" ]; then
	docker-compose build
	$DOCKER_CMD tag mijoco/radsoc_nginx mijoco/radsoc_nginx
	$DOCKER_CMD push mijoco/radsoc_nginx:latest
fi

echo --- radsoc:copying to [ $PATH_DEPLOY ] --------------------------------------------------------------------------------;
printf "\n\n Connectiong to $SERVER.\n"
ssh -i ~/.ssh/id_rsa -p 7019 bob@$SERVER "
  cd ~/hubgit/radsoc
  git pull
  cp .env.production .env
	docker login
  docker-compose -f docker-compose-images.yml pull
  docker-compose -f docker-compose-images.yml up -d
";

printf "Finished....\n"
printf "\n-----------------------------------------------------------------------------------------------------\n";

exit 0;
