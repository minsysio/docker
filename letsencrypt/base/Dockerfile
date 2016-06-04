Objectifs : 
En partant dun minion neuf 
NGNINX doit deja exister car plugin webroot test /usr/share/nginx/html
generer certificats+ clefs SSL pour DOMAIN_MSO à disposition de NGINX : dans /etc/letsencrypt/live/DOMAIN_MSO
Que les certificats se mettent à jour automatiquement ( CRON ) 

FROM minsysio/letsencrypt:source
# As usual : Thx to phusion and phusion/baseimage ! 
# Thx to DigitalOcean's tutorials, Mitchell Anicas : https://www.digitalocean.com/community/users/manicas 
MAINTAINER Laurent Vincentelli <lvi@minsys.io>
# This, to always keep the latest Let's Encrpyt version. Cloning the Let’s Encrypt github repository.
#RUN set -x \
#	&& apt-get update -y git bc \
#	&& git clone https://github.com/letsencrypt/letsencrypt /opt/letsencrypt

ENV DOMAIN_MSO cloud.minsys.io 

RUN ./letsencrypt-auto certonly -a webroot --webroot-path=/usr/share/nginx/html -d labs.cloud.minsys.io -n -m support@minsys.io

 
WORKDIR /opt/letsencrypt
#Directory where up to date cert + key are present. 
VOLUME ["/etc/letsencrypt/live"]
#Default input ports, list should grow with several inputs. 5200s are internal (LAN) inputs, 5300s are external (WAN)
ENV DOMAIN_MSO cloud.minsys.io 

RUN ./letsencrypt-auto certonly -a webroot --webroot-path=/usr/share/nginx/html -d labs.cloud.minsys.io -n -m support@minsys.io

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*