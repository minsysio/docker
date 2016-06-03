#! /bin/sh

### BEGIN INIT INFO
# Provides:             elasticsearch at startup
# Required-Start:       see /etc/init.d/elasticserach for more info 
# Required-Stop:        see /etc/init.d/elasticserach for more info 
# Short-Description:    You know, for search.
### END INIT INFO

set -e

#Source the lsb functions to perform the following operations
 . /lib/lsb/init-functions

log_daemon_msg "my_init is starting elasticsearch"
/etc/init.d/elasticsearch start

exit 0