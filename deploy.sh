#!/bin/bash -e
#
############################################################

export SERVER=hume.brightblock.org
export PROFILE=staging
if [ "$SERVER" == "hume.brightblock.org" ]; then
	PROFILE=production
fi

echo -----------------------------------------------------------------------------------;
echo building all back ends;
echo -----------------------------------------------------------------------------------;
mvn -f ../ms-assets/pom.xml -Dmaven.test.skip=true clean install
mvn -f ../ms-clients/pom.xml -Dmaven.test.skip=true clean install
mvn -f ../ms-mesh/pom.xml -Dmaven.test.skip=true clean install
echo -----------------------------------------------------------------------------------;
echo building all front ends;
echo -----------------------------------------------------------------------------------;
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
pushd ../fe-shellapp;
#./deploy.sh;
popd;
pushd ../fe-assets
#./deploy.sh;
popd;

printf "\n-----------------------------------------------------------------------------------------------------\n";
printf "Running script: $0 \n";
printf "Against destination server: $SERVER \n";
printf "Active profile: $PROFILE \n";
printf "\n-----------------------------------------------------------------------------------------------------\n";

DOCKER_ID_USER='mijoco'
DOCKER_COMPOSE_CMD='docker-compose'
DOCKER_CMD='docker'

$DOCKER_COMPOSE_CMD build
pwd
#$DOCKER_COMPOSE_CMD -f docker-compose.yml push
#exit 0;
#--force-rm --no-cache

#$DOCKER_CMD login -u mijoco --password-stdin
#sleep 10
printf "\n- Tagging ---------------------------------------------------------------------------------------------------\n";

$DOCKER_CMD tag rs-docker_clients  $DOCKER_ID_USER/rs-docker_clients
$DOCKER_CMD push $DOCKER_ID_USER/rs-docker_clients

$DOCKER_CMD tag rs-docker_mesh  $DOCKER_ID_USER/rs-docker_mesh
$DOCKER_COMPOSE_CMD push mesh

$DOCKER_CMD tag rs-docker_nginx  $DOCKER_ID_USER/rs-docker_nginx
$DOCKER_COMPOSE_CMD push nginx

$DOCKER_CMD tag rs-docker_assets  $DOCKER_ID_USER/rs-docker_assets
$DOCKER_COMPOSE_CMD push assets


exit 0;

printf "\n-----------------------------------------------------------------------------------------------------\n";
printf "Moving to production server to pull new images....\n"

printf "\n\nConnectiong to $SERVER.\n"
ssh -i ~/.ssh/id_rsa -p 7019 bob@$SERVER "
  cd ~/hubgit/rs-docker
  git pull
	cp .env-prod .env
	docker login
  docker-compose -f docker-compose-images.yml pull
  docker-compose -f docker-compose-images.yml up -d
";

popd > /dev/null

printf "Finished....\n"
printf "\n-----------------------------------------------------------------------------------------------------\n";

exit 0;
