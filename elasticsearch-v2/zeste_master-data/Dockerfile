
FROM minsysio/elasticsearch-v2:source
# As usual : Thx to phusion and phusion/baseimage ! 
# Thx to DigitalOcean's tutorials, Mitchell Anicas : https://www.digitalocean.com/community/users/manicas 
MAINTAINER Laurent Vincentelli <lvi@minsys.io>
# This, to always keep the latest 2.x elasticsearch version.  
RUN set -x \
	&& apt-get update \
	&& apt-get upgrade -y elasticsearch 
#Can be used to overide startup script provided variables. 
COPY default /etc/default
#Elasticsearch config 
COPY config /etc/elasticsearch

WORKDIR /usr/share/elasticsearch
#config, data & log volume mapping  ( minion : /opt/elasticsearch/* ).  
VOLUME ["/etc/elasticsearch", "/var/lib/elasticsearch", "/var/log/elasticsearch"]
#API REST JSON + HTTP Transport
EXPOSE 9200 9300
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*