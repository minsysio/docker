FROM minsysio/kibana-v4:source
# As usual : Thx to phusion and phusion/baseimage ! 
# Thx to DigitalOcean's tutorials, Mitchell Anicas : https://www.digitalocean.com/community/users/manicas 
MAINTAINER Laurent Vincentelli <lvi@minsys.io>
# This, to always keep the latest 4.5.x kibana version.  
RUN set -x \
	&& apt-get update \
	&& apt-get upgrade -y kibana
#Can be used to overide startup script provided variables. 
WORKDIR /opt/kibana/
#config volume mapping  ( minion : /opt/kibana/* ).  
VOLUME ["/opt/kibana/config"]
#Node.js' kibana default listenning port.  
EXPOSE 5601
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*