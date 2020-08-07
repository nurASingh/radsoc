#!/bin/bash -e

printf "\n-----------------------------------------------------------------------------------------------------\n";
printf "Running script: $0 \n";
printf "\n-----------------------------------------------------------------------------------------------------\n";

export SERVICE=$1

pwd
echo -----------------------------------------------------------------------------------;
echo building all front ends;
echo -----------------------------------------------------------------------------------;

if [ -z "${SERVICE}" ]; then
  pushd ../fe-shellapp;
  ./deploy.sh;
  popd;
  pushd ../fe-assets
  ./deploy.sh;
  popd;
  pushd ../fe-rpay
  ./deploy.sh;
  popd;
  pushd ../fe-articles
  ./deploy.sh;
  popd;
fi

if [ "$SERVICE" == "articles" ]; then
  pushd ../fe-articles
  ./deploy.sh;
  popd;
fi
if [ "$SERVICE" == "assets" ]; then
  pushd ../fe-assets
  ./deploy.sh;
  popd;
fi
if [ "$SERVICE" == "lsat" ]; then
  pushd ../fe-rpay
  ./deploy.sh;
  popd;
fi
if [ "$SERVICE" == "shellapp" ]; then
  pushd ../fe-shellapp;
  ./deploy.sh;
  popd;
fi

exit 0;
