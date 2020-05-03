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
  pushd ../brightblock-loop;
  ./deploy.sh;
  popd;
  pushd ../fe-osloop
  ./deploy.sh;
  popd;
fi

if [ "$SERVICE" == "osloop" ]; then
  pushd ../fe-osloop
  ./deploy.sh;
  popd;
fi
if [ "$SERVICE" == "loop" ]; then
  pushd ../brightblock-loop;
  ./deploy.sh;
  popd;
fi

exit 0;
