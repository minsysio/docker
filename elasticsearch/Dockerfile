
FROM minsysio/elasticsearch-tmp:0.1
MAINTAINER Laurent Vincentelli <lvi@minsys.io>
#Load elasticsearch default variables to be used by elasticsearch startup script. Can be used to overide startup script provided variables. 
COPY default /etc/default/
# As usual : Thx to phusion and phusion/baseimage ! 
# Thx to DigitalOcean's tutorials, Mitchell Anicas : https://www.digitalocean.com/community/users/manicas  
# This, to always keep the latest 2.x elasticsearch version.  
RUN set -x \
	&& apt-get update \
	&& apt-get upgrade -y elasticsearch \
	&& rm -rf /var/lib/apt/lists/*

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
COPY config /usr/share/elasticsearch/config/
#config, data, log, volume mapping  ( minion : /opt/elasticsearch/* ).  
VOLUME ["/usr/share/elasticsearch/config", "/usr/share/elasticsearch/data", "/usr/share/elasticsearch/logs"]
#API REST JSON + HTTP Transport
EXPOSE 9200 9300
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

