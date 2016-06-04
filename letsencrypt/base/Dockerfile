FROM minsysio/letsencrypt:source
# As usual : Thx to phusion and phusion/baseimage ! 
# Thx to DigitalOcean's tutorials, Mitchell Anicas : https://www.digitalocean.com/community/users/manicas 
MAINTAINER Laurent Vincentelli <lvi@minsys.io>
# This, to always keep the latest Let's Encrpyt version. Cloning the Let’s Encrypt github repository.
#RUN set -x \
#	&& apt-get update -y git bc \
#	&& git clone https://github.com/letsencrypt/letsencrypt /opt/letsencrypt
 
WORKDIR /opt/letsencrypt
#Directory where up to date cert + key are present. 
VOLUME ["/etc/letsencrypt/live"]
#Default input ports, list should grow with several inputs. 5200s are internal (LAN) inputs, 5300s are external (WAN)
EXPOSE 
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*