#!/bin/bash -e

export SERVICE=$1

printf "\n-----------------------------------------------------------------------------------------------------\n";
printf "Running script: $0 \n";
printf "Running argument: $1 \n";
printf "\n-----------------------------------------------------------------------------------------------------\n";

pwd
if [ -z "${SERVICE}" ]; then
  echo -----------------------------------------------------------------------------------;
  echo building all services;
  echo -----------------------------------------------------------------------------------;
  mvn -f ../ms-assets/pom.xml -Dmaven.test.skip=true clean install
  mvn -f ../ms-lsat/pom.xml -Dmaven.test.skip=true clean install
  mvn -f ../ms-mesh/pom.xml -Dmaven.test.skip=true clean install
fi
if [ "$SERVICE" == "assets" ]; then
  mvn -f ../ms-assets/pom.xml -Dmaven.test.skip=true clean install
fi
if [ "$SERVICE" == "lsat" ]; then
  mvn -f ../ms-lsat/pom.xml -Dmaven.test.skip=true clean install
fi
if [ "$SERVICE" == "mesh" ]; then
  mvn -f ../ms-mesh/pom.xml -Dmaven.test.skip=true clean install
fi

docker-compose build
docker-compose up -d

if [ -z "${SERVICE}" ]; then
  echo -----------------------------------------------------------------------------------;
  echo building all front ends;
  echo -----------------------------------------------------------------------------------;
  pushd ../fe-shellapp;
  ./deploy.sh;
  popd;
  pushd ../fe-assets
  ./deploy.sh;
  popd;
fi

exit 0;
