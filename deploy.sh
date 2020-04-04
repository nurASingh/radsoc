#!/bin/bash -e

export APP_NAME=assets
export PATH_DEPLOY=../rs-docker/volumes/www/$APP_NAME
printf "\n-----------------------------------------------------------------------------------------------------\n";
printf "Running script: $0 \n";
printf "From git (vs host machine build): $BUILD_FROM_GIT \n";
printf "\n-----------------------------------------------------------------------------------------------------\n";
#DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
#pushd $DIR/../brightblock > /dev/null

pwd
npm run build
mkdir -p $PATH_DEPLOY
mkdir -p $PATH_DEPLOY/../fallback
mv dist/custom* $PATH_DEPLOY/../fallback
cp -r dist/* $PATH_DEPLOY/.

exit 0;
