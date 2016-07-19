FROM minsysio/logstash-v2:source
# As usual : Thx to phusion and phusion/baseimage ! 
# Thx to DigitalOcean's tutorials, Mitchell Anicas : https://www.digitalocean.com/community/users/manicas 
MAINTAINER Laurent Vincentelli <lvi@minsys.io>
# This, to always keep the latest 2.3.x logstash version.  
RUN set -x \
	&& apt-get update \
	&& apt-get upgrade -y logstash
 
WORKDIR /etc/logstash/conf.d
#config : input/filter/output & ssl -Beats stack- volume mapping  ( minion : /opt/logstash/* ).  
VOLUME ["/etc/logstash/conf.d", "/etc/logstash/ssl"]
#Default input ports, list should grow with several inputs. 5200s are internal (LAN) inputs, 5300s are external (WAN)
EXPOSE 5200 5300 
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*