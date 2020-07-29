#!/usr/bin/env bash
set -e;

export profile=$1
filename='.env'
n=1
while read line; do
  # reading each line
  echo "Line No. $n : $line"
  profile=$line
  n=$((n+1))
done < $filename

function __init_nginx() {
  echo "Initialising Nginx. Timeout set to $__SERVICE_STARTUP_TIMEOUT";
  echo "Active profile: $profile";
  count=0;
  # Wait for the service to get up and running
  until timeout 5 service nginx status > /dev/null 2>/dev/null || (( count >= $__SERVICE_STARTUP_TIMEOUT ));
  do
    count=$(( count + 1 ));
    echo "Nginx not started yet. Continuing... (Checks: $count)";
    sleep 1;
  done;

  if (( count >= $__SERVICE_STARTUP_TIMEOUT ));
  then
    echo "Nginx failed to startup properly after $__SERVICE_STARTUP_TIMEOUT seconds. Exiting with fail code.";
    exit 1;
  fi;

  # Enable all sites
  echo "Enabling sites $profile";
  #ln -sf "/etc/nginx/sites-available/assets.com" "/etc/nginx/sites-enabled"
  echo "Enabling sites $profile";
  if [ "$profile" == "production" ]; then
	printf "\n- Linking Hume files \n";
    ln -sf "/etc/nginx/sites-available/api.risidio.com" "/etc/nginx/sites-enabled"
    ln -sf "/etc/nginx/sites-available/hubber.risidio.com" "/etc/nginx/sites-enabled"
    ln -sf "/etc/nginx/sites-available/login.risidio.com" "/etc/nginx/sites-enabled"
    ln -sf "/etc/nginx/sites-available/stax.risidio.com" "/etc/nginx/sites-enabled"
    ln -sf "/etc/nginx/sites-available/www.dbid.io" "/etc/nginx/sites-enabled"
    ln -sf "/etc/nginx/sites-available/www.loopbomb.com" "/etc/nginx/sites-enabled"
    ln -sf "/etc/nginx/sites-available/www.radicle.art" "/etc/nginx/sites-enabled"
    ln -sf "/etc/nginx/sites-available/www.risid.io" "/etc/nginx/sites-enabled"
    ln -sf "/etc/nginx/sites-available/www.risidio.com" "/etc/nginx/sites-enabled"
    ln -sf "/etc/nginx/sites-available/www.subs.risidio.com" "/etc/nginx/sites-enabled"
  elif [ "$profile" == "staging" ]; then
  	printf "\n- Linking Zeno files \n";
    ln -sf "/etc/nginx/sites-available/test.loopbomb.com" "/etc/nginx/sites-enabled"
    ln -sf "/etc/nginx/sites-available/tstax.risidio.com" "/etc/nginx/sites-enabled"
    ln -sf "/etc/nginx/sites-available/tapi.risidio.com" "/etc/nginx/sites-enabled"
  else
  	printf "\n- No profile defined.. $profile \n";
    ln -sf "/etc/nginx/sites-available/domains.local" "/etc/nginx/sites-enabled"
  fi;

  echo "Site enablement completed";
  touch /var/log/access.log
  touch /var/log/error.log
  chmod ugo+rw /var/log/access.log
  chmod ugo+rw /var/log/error.log
  echo "Reloading Nginx configuration";
  service nginx reload;
  echo "Nginx configuration done";

  echo "Initialisation of Nginx completed (Took roughly $count seconds)";
}

__init_nginx & nginx -g 'daemon off;';
