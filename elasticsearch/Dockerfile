
FROM minsysio/oracle-jdk8
MAINTAINER Laurent Vincentelli <lvi@minsys.io>


#Avant tout copier 50_elasticsearch dans /etc/my_init.d/50_elasticsearch pour que my_init puisse lancer elasticsearch au démarrage
#Installer els
##apt-get
##creer l'arborescene 

# Inspired by : gerardorochin on github. see below. 
# https://github.com/komljen/dockerfile-examples
# https://packages.elasticsearch.org/GPG-KEY-elasticsearch
RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 46095ACC8548582C1A2699A9D27D666CD88E42B4

ENV ELASTICSEARCH_MAJOR 2.3
ENV ELASTICSEARCH_VERSION 2.3.3
ENV ELASTICSEARCH_REPO_BASE http://packages.elasticsearch.org/elasticsearch/2.x/debian

RUN echo "deb $ELASTICSEARCH_REPO_BASE stable main" > /etc/apt/sources.list.d/elasticsearch.list

RUN set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends elasticsearch=$ELASTICSEARCH_VERSION \
	&& rm -rf /var/lib/apt/lists/*

#Neccessaire ??? 
ENV PATH /usr/share/elasticsearch/bin:$PATH

#Se placer dans ce répertoire pour creer arbo 
WORKDIR /usr/share/elasticsearch


RUN set -ex \
	&& for path in \
		./data \
		./logs \
		./config \
		./config/scripts \
	; do \
		mkdir -p "$path"; \
		chown -R elasticsearch:elasticsearch "$path"; \
	done

#ok rapatrier la config 
COPY config ./config

#Mapper les volumes data, log, config sur l'hote dans /opt/elasticsearch/*
VOLUME /usr/share/elasticsearch/data

#NON, my_init s'en charge 
#COPY docker-entrypoint.sh /

EXPOSE 9200 9300

#
#ENTRYPOINT ["/docker-entrypoint.sh"]
#CMD ["elasticsearch"]
