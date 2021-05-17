#!/bin/bash -e
#
############################################################

export TAG=zeno
export DEPLOYMENT=$1
export SERVER=zeno.brightblock.org
if [ "$DEPLOYMENT" == "prod" ]; then
  SERVER=hume.brightblock.org;
  TAG=hume;
fi
export DOCKER_ID_USER='mijoco'
export DOCKER_COMPOSE_CMD='docker-compose'
export DOCKER_CMD='docker'

echo --- radsoc:copying to [ $PATH_DEPLOY ] --------------------------------------------------------------------------------;
printf "\n\n Connectiong to $SERVER.\n"
ssh -i ~/.ssh/id_rsa -p 7019 root@$SERVER "
  cd /home/bob/hubgit/radsoc
  docker stop rs_mongodb
  tar cvf db_$TAG.tar volumes/data/db
  gzip db_$TAG.tar
  docker start rs_mongodb
";
rsync -r -e "ssh  -p 7019" bob@$SERVER:/home/bob/hubgit/radsoc/db_$TAG.tar.gz ~/hubgit/radicle-solutions/radsoc/backups/.

printf "Finished....\n"
printf "\n-----------------------------------------------------------------------------------------------------\n";

exit 0;