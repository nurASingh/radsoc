#!/bin/bash -e
#
############################################################

export SERVICE=$1
export DEPLOYMENT=$2
export SERVER=zeno.brightblock.org
if [ "$DEPLOYMENT" == "prod" ]; then
  SERVER=hume.brightblock.org;
fi
export DOCKER_ID_USER='mijoco'
export DOCKER_COMPOSE_CMD='docker-compose'
export DOCKER_CMD='docker'

if [ "$SERVICE" == "all" ]; then
  mvn -f ../ms-assets/pom.xml -Dmaven.test.skip=true clean install
  mvn -f ../ms-lsat/pom.xml -Dmaven.test.skip=true clean install
  mvn -f ../ms-mesh/pom.xml -Dmaven.test.skip=true clean install
  mvn -f ../ms-search/pom.xml -Dmaven.test.skip=true clean install

	docker-compose build
	$DOCKER_CMD tag mijoco/stacksmate mijoco/stacksmate
	$DOCKER_CMD tag mijoco/radsoc_assets mijoco/radsoc_assets
	$DOCKER_CMD tag mijoco/radsoc_lsat mijoco/radsoc_lsat
	$DOCKER_CMD tag mijoco/radsoc_mesh  mijoco/radsoc_mesh
	$DOCKER_CMD tag mijoco/radsoc_search  mijoco/radsoc_search
	$DOCKER_CMD tag mijoco/radsoc_nginx mijoco/radsoc_nginx

	$DOCKER_CMD push mijoco/stacksmate:latest
	$DOCKER_CMD push mijoco/radsoc_assets:latest
	$DOCKER_CMD push mijoco/radsoc_lsat:latest
	$DOCKER_CMD push mijoco/radsoc_mesh:latest
	$DOCKER_CMD push mijoco/radsoc_search:latest
	$DOCKER_CMD push mijoco/radsoc_nginx:latest
fi
if [ "$SERVICE" == "assets" ]; then
  	mvn -f ../ms-assets/pom.xml -Dmaven.test.skip=true clean install
	docker-compose build assets
	$DOCKER_CMD tag mijoco/radsoc_assets mijoco/radsoc_assets
	$DOCKER_CMD push mijoco/radsoc_assets:latest
fi
if [ "$SERVICE" == "stacksmate" ]; then
	docker-compose build stacksmate
	$DOCKER_CMD tag mijoco/stacksmate mijoco/stacksmate
	$DOCKER_CMD push mijoco/stacksmate:latest
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
if [ "$SERVICE" == "search" ]; then
  	mvn -f ../ms-search/pom.xml -Dmaven.test.skip=true clean install
	docker-compose build
	$DOCKER_CMD tag mijoco/radsoc_search  mijoco/radsoc_search
	$DOCKER_CMD push mijoco/radsoc_search:latest
fi
if [ "$SERVICE" == "nginx" ]; then
	docker-compose build
	$DOCKER_CMD tag mijoco/radsoc_nginx mijoco/radsoc_nginx
	$DOCKER_CMD push mijoco/radsoc_nginx:latest
fi

echo --- radsoc:copying to [ $PATH_DEPLOY ] --------------------------------------------------------------------------------;
printf "\n\n Connectiong to $SERVER.\n"

if [ -z "${SERVICE}" ]; then
ssh -i ~/.ssh/id_rsa -p 7019 bob@$SERVER "
  cd /home/bob/hubgit/radsoc
  # git pull
  # cp .env.production .env
  cat .env
  docker login
  . ~/.profile
  docker-compose -f docker-compose-images.yml pull
  docker-compose -f docker-compose-images.yml down
  docker-compose -f docker-compose-images.yml up -d
";
else
ssh -i ~/.ssh/id_rsa -p 7019 bob@$SERVER "
  cd /home/bob/hubgit/radsoc
  cat .env
  docker login
  . ~/.profile
  docker-compose -f docker-compose-images.yml pull  
  docker-compose -f docker-compose-images.yml stop $SERVICE
  docker-compose -f docker-compose-images.yml rm $SERVICE 
  docker-compose -f docker-compose-images.yml create $SERVICE
  docker-compose -f docker-compose-images.yml start $SERVICE
";
fi

printf "Finished....\n"
printf "\n-----------------------------------------------------------------------------------------------------\n";

exit 0;
