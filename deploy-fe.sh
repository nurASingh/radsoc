#!/bin/bash -e
#
############################################################

export SERVICE=$1
export SERVER=hume.brightblock.org

export PATH_DEPLOY=./volumes/www/production/assets
mkdir -p $PATH_DEPLOY
mkdir -p $PATH_DEPLOY/../fallback

if [ -z "${SERVICE}" ]; then
	pushd ../fe-shellapp;
  echo --- fe-shellapp:build-prod --------------------------------------------------------------------------------;
	npm run build-prod
	popd;

	pushd ../fe-assets
  echo --- fe-assets:build-prod --------------------------------------------------------------------------------;
	npm run build-prod
	popd;

	pushd ../fe-articles
  echo --- fe-assets:build-prod --------------------------------------------------------------------------------;
	npm run build-prod
	popd;

	pushd ../fe-lsat
	echo --- fe-lsat:build-prod --------------------------------------------------------------------------------;
	npm run build-prod
	popd;

fi
if [ "$SERVICE" == "assets" ]; then
	pushd ../fe-assets
  echo --- fe-assets:build-prod --------------------------------------------------------------------------------;
	npm run build-prod
	popd;
fi
if [ "$SERVICE" == "shellapp" ]; then
	pushd ../fe-shellapp;
  echo --- fe-shellapp:build-prod --------------------------------------------------------------------------------;
	npm run build-prod
	popd;
fi
if [ "$SERVICE" == "lsat" ]; then
	pushd ../fe-lsat;
  echo --- fe-lsat:build-prod --------------------------------------------------------------------------------;
	npm run build-prod
	popd;
fi
if [ "$SERVICE" == "articles" ]; then
	pushd ../fe-articles;
  echo --- fe-articles:build-prod --------------------------------------------------------------------------------;
	npm run build-prod
	popd;
fi

echo --- radsoc:copying to [ $PATH_DEPLOY ] --------------------------------------------------------------------------------;
cp ../fe-shellapp/dist/custom* $PATH_DEPLOY/../fallback
cp -r ../fe-shellapp/dist/* $PATH_DEPLOY/.
cp ../fe-assets/dist/assets-entry.js $PATH_DEPLOY/.
cp ../fe-articles/dist/articles-entry.js $PATH_DEPLOY/.
cp ../fe-lsat/dist/lsat-entry.js $PATH_DEPLOY/.

rsync -aP -e "ssh  -p 7019" $PATH_DEPLOY/* bob@$SERVER:/var/www/radicle402

printf "Finished....\n"
printf "\n-----------------------------------------------------------------------------------------------------\n";

exit 0;
