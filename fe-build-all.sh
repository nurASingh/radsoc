#!/bin/bash -e

export SERVICE=$1

printf "\n-----------------------------------------------------------------------------------------------------\n";
printf "Running script: $0 \n";
printf "Running argument: $1 \n";
printf "\n-----------------------------------------------------------------------------------------------------\n";

pwd

if [ -z "${SERVICE}" ]; then
  echo -----------------------------------------------------------------------------------;
  echo building all front ends;
  echo -----------------------------------------------------------------------------------;
  pushd ../fe-shellapp;
  # nvm use v11.14.0
  ./deploy.sh;
  popd;
  pushd ../fe-assets
  # nvm use v11.14.0
  ./deploy.sh;
  popd;
fi

exit 0;
