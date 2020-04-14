#!/bin/bash -e
#
############################################################

export SERVER=hume.brightblock.org
export PROFILE=staging
if [ "$SERVER" == "hume.brightblock.org" ]; then
	PROFILE=production
fi

echo -----------------------------------------------------------------------------------;
echo building and upping;
echo -----------------------------------------------------------------------------------;

./build.sh

printf "\n-----------------------------------------------------------------------------------------------------\n";
printf "Running script: $0 \n";
printf "Against destination server: $SERVER \n";
printf "Active profile: $PROFILE \n";
printf "\n-----------------------------------------------------------------------------------------------------\n";

export DOCKER_ID_USER='mijoco'
export DOCKER_COMPOSE_CMD='docker-compose'
export DOCKER_CMD='docker'

printf "\n- Tagging ---------------------------------------------------------------------------------------------------\n";

#$DOCKER_CMD commit radsoc_assets $DOCKER_ID_USER/radsoc_assets

$DOCKER_CMD tag mijoco/radsoc_assets mijoco/radsoc_assets
$DOCKER_CMD tag mijoco/radsoc_lsat mijoco/radsoc_lsat
$DOCKER_CMD tag mijoco/radsoc_mesh  mijoco/radsoc_mesh
$DOCKER_CMD tag mijoco/radsoc_nginx mijoco/radsoc_nginx

$DOCKER_CMD push mijoco/radsoc_assets:latest
$DOCKER_CMD push mijoco/radsoc_lsat:latest
$DOCKER_CMD push mijoco/radsoc_mesh:latest
$DOCKER_CMD push mijoco/radsoc_nginx:latest

printf "\n-----------------------------------------------------------------------------------------------------\n";
printf "Moving to production server to pull new images....\n"

git add .
git commit -m "commit from deployment"
git push

#exit 0;

printf "\n\nConnectiong to $SERVER.\n"
ssh -i ~/.ssh/id_rsa -p 7019 bob@$SERVER "
  cd ~/hubgit/radsoc
  git pull
	cp .env-prod .env
	docker login
  docker-compose -f docker-compose-images.yml pull
  docker-compose -f docker-compose-images.yml up -d
";

printf "Finished....\n"
printf "\n-----------------------------------------------------------------------------------------------------\n";

exit 0;
