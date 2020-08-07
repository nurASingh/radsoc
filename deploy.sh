#!/bin/bash -e
#
############################################################

export SERVER=hume.brightblock.org
export PROFILE=staging
if [ "$SERVER" == "hume.brightblock.org" ]; then
	PROFILE=production
fi
export DOCKER_ID_USER='mijoco'
export DOCKER_COMPOSE_CMD='docker-compose'
export DOCKER_CMD='docker'

echo -----------------------------------------------------------------------------------;
echo building all services;
echo -----------------------------------------------------------------------------------;
mvn -f ../ms-assets/pom.xml -Dmaven.test.skip=true clean install
mvn -f ../ms-lsat/pom.xml -Dmaven.test.skip=true clean install
mvn -f ../ms-mesh/pom.xml -Dmaven.test.skip=true clean install

echo \n\n\n-----------------------------------------------------------------------------------;
echo building images;
echo -----------------------------------------------------------------------------------;
cp .env.production .env
docker-compose build

echo \n\n\n-----------------------------------------------------------------------------------;
echo building all front ends;
echo -----------------------------------------------------------------------------------;

PATH_DEPLOY=./volumes/www/production/assets
mkdir -p $PATH_DEPLOY
mkdir -p $PATH_DEPLOY/../fallback

pushd ../fe-shellapp;
npm run build-prod
popd;
cp ../fe-shellapp/dist/custom* $PATH_DEPLOY/../fallback
cp -r ../fe-shellapp/dist/* $PATH_DEPLOY/.

pushd ../fe-assets
npm run build-prod
popd;
cp ../fe-assets/dist/assets-entry.js $PATH_DEPLOY/.

pushd ../fe-rpay
npm run build-prod
popd;
cp ../fe-rpay/dist/rpay-entry*.js $PATH_DEPLOY/.

pushd ../fe-articles
npm run build-prod
popd;
cp ../fe-articles/dist/articles-entry.js $PATH_DEPLOY/.

rsync -aP -e "ssh  -p 7019" $PATH_DEPLOY/* bob@$SERVER:/var/www/risidio402

echo \n\n\n-----------------------------------------------------------------------------------;
echo pushing images;
echo -----------------------------------------------------------------------------------;

#$DOCKER_CMD commit radsoc_assets $DOCKER_ID_USER/radsoc_assets

$DOCKER_CMD tag mijoco/radsoc_assets mijoco/radsoc_assets
$DOCKER_CMD tag mijoco/radsoc_lsat mijoco/radsoc_lsat
$DOCKER_CMD tag mijoco/radsoc_mesh  mijoco/radsoc_mesh
$DOCKER_CMD tag mijoco/radsoc_nginx mijoco/radsoc_nginx

$DOCKER_CMD push mijoco/radsoc_assets:latest
$DOCKER_CMD push mijoco/radsoc_lsat:latest
$DOCKER_CMD push mijoco/radsoc_mesh:latest
$DOCKER_CMD push mijoco/radsoc_nginx:latest

echo \n\n\n-----------------------------------------------------------------------------------;
echo pushing radson repo changes;
echo -----------------------------------------------------------------------------------;

git add .
git commit -m "commit from deployment"
git push

#exit 0;
printf "\n\n Connectiong to $SERVER.\n"
ssh -i ~/.ssh/id_rsa -p 7019 bob@$SERVER "
  cd ~/hubgit/radsoc
  git pull
	cp .env.production .env
	docker login
  docker-compose -f docker-compose-images.yml pull
  docker-compose -f docker-compose-images.yml down
  docker-compose -f docker-compose-images.yml up -d
";

printf "Finished....\n"
printf "\n-----------------------------------------------------------------------------------------------------\n";

exit 0;
