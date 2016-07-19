FROM minsysio/logstash-v2:source
# As usual : Thx to phusion and phusion/baseimage ! 
# Thx to DigitalOcean's tutorials, Mitchell Anicas : https://www.digitalocean.com/community/users/manicas 
MAINTAINER Laurent Vincentelli <lvi@minsys.io>
# This, to always keep the latest 2.3.x logstash version.  
RUN set -x \
	&& apt-get update \
	&& apt-get upgrade -y logstash
#Configuration to be copied :  
COPY conf.d /etc/logstash/conf.d
#Volume mapping - config : input/filter/output & ssl ( on minion : /opt/logstash/* ).  
VOLUME ["/etc/logstash/conf.d", "/var/log/logstash", "/etc/pki/tls/certs", "/etc/pki/tls/private"]
#Default input ports, list should grow with several inputs. 5200s are internal (LAN/MAN) inputs, 5300s are external (WAN)
#5301 exposed to siemprobe.
EXPOSE 5301 
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*