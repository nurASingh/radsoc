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
  mvn -f ../af-ms-assets/pom.xml -Dmaven.test.skip=true clean install
  mvn -f ../af-ms-clients/pom.xml -Dmaven.test.skip=true clean install
  mvn -f ../af-ms-mesh/pom.xml -Dmaven.test.skip=true clean install
fi
if [ "$SERVICE" == "assets" ]; then
  mvn -f ../af-ms-assets/pom.xml -Dmaven.test.skip=true clean install
fi
if [ "$SERVICE" == "clients" ]; then
  mvn -f ../af-ms-clients/pom.xml -Dmaven.test.skip=true clean install
fi
if [ "$SERVICE" == "mesh" ]; then
  mvn -f ../af-ms-mesh/pom.xml -Dmaven.test.skip=true clean install
fi

docker-compose build
docker-compose up -d
exit 0;