#!/bin/bash -e
#
############################################################
PATH_DEPLOY=./volumes/www/production/assets

pushd ../fe-shellapp;
#npm run build-prod
pwd
ls -lt dist
popd;
cp -r ../fe-shellapp/dist/custom_404.html $PATH_DEPLOY/../fallback/
cp -r ../fe-shellapp/dist/* $PATH_DEPLOY/.

exit 0;
