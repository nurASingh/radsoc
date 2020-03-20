FROM openjdk:10-slim
VOLUME /tmp
#ARG JAR_FILE
#COPY ${JAR_FILE} app.jar
RUN apt-get update \
  && apt-get -y install vim \
  && apt-get -y install iproute2
#    && apt-get -y install software-properties-common \
#    && apt-get -y install python-certbot-nginx
COPY app/brightblock-mam.jar brightblock-mam.jar
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-Xdebug", "-Xrunjdwp:server=y,transport=dt_socket,address=8000,suspend=n","-jar","/brightblock-mam.jar"]
