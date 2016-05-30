# Thx @ phusion & phusion/baseimage as base image for this base image 
FROM minsysio/ubuntu-trusty_base:0.1
MAINTAINER Laurent Vincentelli <lvi@minsys.io>

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# ...put your own build instructions here...
# /sbin/my_init starts sshd, so expose default ssh port via docker proxy 
EXPOSE 22 
# ...End of your own build instructions here...

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
