
FROM minsysio/oracle-jdk8:0.1
MAINTAINER Laurent Vincentelli <lvi@minsys.io>
#Load elasticsearch default variables to be used by elasticsearch startup script
COPY default /etc/default/
#Load the elasticsearch startup script
COPY my_init /etc/my_init.d/
# Inspired by : gerardorochin on github. see below. 
# https://github.com/komljen/dockerfile-examples
# https://packages.elasticsearch.org/GPG-KEY-elasticsearch
RUN wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

ENV ELASTICSEARCH_MAJOR 2.3
ENV ELASTICSEARCH_VERSION 2.3.3
ENV ELASTICSEARCH_REPO_BASE http://packages.elastic.co/elasticsearch/2.x/debian

RUN echo "deb $ELASTICSEARCH_REPO_BASE stable main" > /etc/apt/sources.list.d/elasticsearch.list

RUN set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends elasticsearch=$ELASTICSEARCH_VERSION \
	&& rm -rf /var/lib/apt/lists/*

ENV PATH /usr/share/elasticsearch/bin:$PATH

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
#elasticsearch.yml & logging.yml import. 
COPY config ./config
#config, data, log, volume mapping  ( minion : /opt/elasticsearch/* ).  
VOLUME ["/usr/share/elasticsearch/config", "/usr/share/elasticsearch/data", "/usr/share/elasticsearch/logs"]
#API REST JSON + HTTP Transport
EXPOSE 9200 9300
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

