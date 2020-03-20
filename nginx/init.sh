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
  if [ "$profile" == "production" ]; then
	printf "\n- Linking prod files \n";
    ln -sf "/etc/nginx/sites-available/www.loopbomb.com" "/etc/nginx/sites-enabled"
  elif [ "$profile" == "staging" ]; then
	printf "\n- Linking staging files \n";
    ln -sf "/etc/nginx/sites-available/test.loopbomb.com" "/etc/nginx/sites-enabled"
  else
	printf "\n- No profile defined.. $profile \n";
  	exit 1;
  fi;
#  for AVAILABLE_SITE in $(find /etc/nginx/sites-available/*); do
#    echo "Enabling $AVAILABLE_SITE";
#    ln -sf "$AVAILABLE_SITE" "/etc/nginx/sites-enabled"
#  done
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
