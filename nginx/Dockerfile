FROM nginx:stable

MAINTAINER Mike Cohen "mike@brightblock.org"

RUN apt-get update \
  && apt-get -y install vim \
  && apt-get -y install iproute2
#    && apt-get -y install software-properties-common \
#    && apt-get -y install python-certbot-nginx

COPY conf/nginx /etc/nginx

RUN /bin/bash -c "mkdir -p /var/log/nginx"
RUN /bin/bash -c "mkdir -p /etc/nginx/sites-enabled"
RUN /bin/bash -c "mkdir -p /etc/letsencrypt"
RUN /bin/bash -c "mkdir -p /var/www"
RUN /bin/bash -c "mkdir -p /data/nginx/cache"
#COPY www/ /var/www/

COPY init.sh /init.sh

ENV __SERVICE_STARTUP_TIMEOUT 60
#ARG spring_profiles_active
#ENV spring_profiles_active $spring_profiles_active

ENTRYPOINT ["bash"]
CMD ["/init.sh"]
