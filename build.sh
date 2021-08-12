#!/bin/bash -e

export SERVICE=$1

printf "\n-----------------------------------------------------------------------------------------------------\n";
printf "Running script: $0 \n";
printf "Running argument: $1 \n";
printf "\n-----------------------------------------------------------------------------------------------------\n";

pwd
echo \n\n\n-----------------------------------------------------------------------------------;
echo building services;
echo -----------------------------------------------------------------------------------;
if [ -z "${SERVICE}" ]; then
  mvn -f ../ms-assets/pom.xml -Dmaven.test.skip=true clean install
  mvn -f ../ms-lsat/pom.xml -Dmaven.test.skip=true clean install
  mvn -f ../ms-mesh/pom.xml -Dmaven.test.skip=true clean install
  mvn -f ../ms-search/pom.xml -Dmaven.test.skip=true clean install
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
if [ "$SERVICE" == "search" ]; then
  mvn -f ../ms-search/pom.xml -Dmaven.test.skip=true clean install
fi

echo \n\n\n-----------------------------------------------------------------------------------;
echo building images;
echo -----------------------------------------------------------------------------------;
cp .env.local .env
if [ -z "${SERVICE}" ]; then
  docker-compose build $SERVICE
  docker-compose down
  docker-compose up -d
else
  docker-compose up --detach --build $SERVICE
fi

exit 0;
