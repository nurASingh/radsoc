risidio#!/bin/bash -e
#
############################################################

export DEPLOYMENT=$1
PATH_SITES=./nginx/conf/nginx/sites-available
export SERVER=zeno.brightblock.org
if [ "$DEPLOYMENT" == "prod" ]; then
  SERVER=hume.brightblock.org;
fi

echo --- radsoc:copying to [ $PATH_SITES ] --------------------------------------------------------------------------------;

rsync -aP -e "ssh  -p 7019" $PATH_SITES/* root@$SERVER:/etc/nginx/sites-available

ssh -i ~/.ssh/id_rsa -p 7019 root@$SERVER "
  cd /etc/nginx/sites-enabled
  ln -sf "/etc/nginx/sites-available/api.risidio.com" "/etc/nginx/sites-enabled"
  ln -sf "/etc/nginx/sites-available/login.risidio.com" "/etc/nginx/sites-enabled"
  ln -sf "/etc/nginx/sites-available/stax.risidio.com" "/etc/nginx/sites-enabled"
  ln -sf "/etc/nginx/sites-available/www.dbid.io" "/etc/nginx/sites-enabled"
  ln -sf "/etc/nginx/sites-available/www.loopbomb.com" "/etc/nginx/sites-enabled"
  ln -sf "/etc/nginx/sites-available/www.radicle.art" "/etc/nginx/sites-enabled"
  ln -sf "/etc/nginx/sites-available/www.risid.io" "/etc/nginx/sites-enabled"
  ln -sf "/etc/nginx/sites-available/www.risidio.com" "/etc/nginx/sites-enabled"
  ln -sf "/etc/nginx/sites-available/www.subs.risidio.com" "/etc/nginx/sites-enabled"
  ls -lt
";

printf "Finished....\n"
printf "\n-----------------------------------------------------------------------------------------------------\n";

exit 0;
