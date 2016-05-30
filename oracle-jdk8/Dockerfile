# Thx @ phusion & phusion/baseimage as base image. 

FROM minsysio/ubuntu-trusty_base:0.2
MAINTAINER Laurent Vincentelli <lvi@minsys.io>

# Use baseimage-docker's init system.
# CMD ["/sbin/my_init"]
# ...put your own build instructions here...

#Begin of Oracle Java 8 install 
#Inspired by : komljen on github. see below. 
#https://github.com/komljen/dockerfile-examples/blob/master/redis/Dockerfile
ENV JAVA_VERSION 8

RUN \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  echo oracle-java${JAVA_VERSION}-installer shared/accepted-oracle-license-v1-1 select true \
       | /usr/bin/debconf-set-selections && \
  apt-get -y install \
          oracle-java${JAVA_VERSION}-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm /var/cache/oracle-jdk${JAVA_VERSION}-installer/jdk-*.tar.gz

RUN update-alternatives --display java
#End of Oracle Java 8 install 

# ...End of your own build instructions here...
# Clean up APT when done.
RUN apt-get clean && rm -rf /tmp/* /var/tmp/*
