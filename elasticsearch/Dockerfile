
FROM minsysio/oracle-jdk8:0.1
MAINTAINER Laurent Vincentelli <lvi@minsys.io>
#Load elasticsearch default variables to be used by elasticsearch startup script
COPY default /etc/default/
#Load the elasticsearch startup script, yep done w/ the phusion's my_init. 
#COPY my_init /etc/my_init.d/
# As usual thx to DigitalOcean tutorials, Mitchell Anicas : https://www.digitalocean.com/community/users/manicas  
#RUN wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
#RUN echo "deb http://packages.elastic.co/elasticsearch/2.x/debian stable main" > /etc/apt/sources.list.d/elasticsearch-2.x.list
#Always keep the latest 2.x elasticsearch version 
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
COPY config ./config
#config, data, log, volume mapping  ( minion : /opt/elasticsearch/* ).  
VOLUME ["/usr/share/elasticsearch/config", "/usr/share/elasticsearch/data", "/usr/share/elasticsearch/logs"]
#API REST JSON + HTTP Transport
EXPOSE 9200 9300
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

