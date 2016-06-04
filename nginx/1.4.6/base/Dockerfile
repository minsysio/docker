FROM minsysio/nginx:source
# As usual : Thx to phusion and phusion/baseimage ! 
# Thx to DigitalOcean's tutorials, Mitchell Anicas : https://www.digitalocean.com/community/users/manicas 
MAINTAINER Laurent Vincentelli <lvi@minsys.io>
# This, to always keep the latest Let's Encrpyt version. Cloning the Let’s Encrypt github repository.
#RUN set -x \
#	&& apt-get update -y git bc \
#	&& git clone https://github.com/letsencrypt/letsencrypt /opt/letsencrypt
 
WORKDIR 
#Directory where up to date cert + key are present. 
VOLUME ["..........."]
#Default input ports, list should grow with several inputs. 5200s are internal (LAN) inputs, 5300s are external (WAN)
EXPOSE 443
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*



#Strong 2048bit Diffie-Hellman group on minion @ /opt/nginx/ssl/dhparam2048.pem