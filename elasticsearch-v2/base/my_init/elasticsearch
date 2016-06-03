#!/bin/sh
#
# /etc/init.d/elasticsearch -- startup script for Elasticsearch
#
# Written by Miquel van Smoorenburg <miquels@cistron.nl>.
# Modified for Debian GNU/Linux by Ian Murdock <imurdock@gnu.ai.mit.edu>.
# Modified for Tomcat by Stefan Gybas <sgybas@debian.org>.
# Modified for Tomcat6 by Thierry Carrez <thierry.carrez@ubuntu.com>.
# Additional improvements by Jason Brittain <jason.brittain@mulesoft.com>.
# Modified by Nicolas Huray for Elasticsearch <nicolas.huray@gmail.com>.
# Modified by Laurent Vincentelli for cloud.minsys.io compatibility. <lvi@minsys.io>.
#
### BEGIN INIT INFO
# Provides:          elasticsearch
# Required-Start:    $network $remote_fs $named $
# Required-Stop:     $network $remote_fs $named 
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Starts elasticsearch
# Description:       Starts elasticsearch using start-stop-daemon
### END INIT INFO

#Source the lsb functions to perform the following operations
 . /lib/lsb/init-functions

#Must be root to run this startup script. Always true as Docker through my_init launches workloads with root privileges
#Kept for rkt containers. 

if [ `id -u` -ne 0 ]; then
        log_daemon_msg "You need root privileges to run this script"
        exit 1
fi


#Source global startup variables of /etc/default/rcS, if available... 
if [ -r /etc/default/rcS ]; then
        . /etc/default/rcS
fi


# Process display name, Description (Logging..), Daemon name, where is the actual executable, & OPTs to be launched, PID infos & $PATH 
NAME=elasticsearch
DESC="Elasticsearch Server - You Know, for Search ... Running on cloud.minsys.io"

ES_HOME=/usr/share/elasticsearch

DAEMON="$ES_HOME/bin/$NAME"

CONF_DIR=/etc/elasticsearch
DATA_DIR=/var/lib/elasticsearch
LOG_DIR=/var/log/elasticsearch

PID_DIR="/var/run/$NAME"
PID_FILE="$PID_DIR/$NAME.pid" 

DAEMON_OPTS="-d -p $PID_FILE --default.path.home=$ES_HOME --default.path.logs=$LOG_DIR --default.path.data=$DATA_DIR --default.path.conf=$CONF_DIR"

PATH=/bin:/usr/bin:/sbin:/usr/sbin

#Elasticsearch variables. Can be overriden by providing info in /etc/default/elasticsearch.  
ES_HEAP_SIZE=512m
ES_USER=elasticsearch
ES_GROUP=elasticsearch
 
#Source elasticsearch global variables of /etc/default/elasticsearch, this will override the previous config. 
#By default this is a no content file. 
if [ -r /etc/default/elasticsearch ]; then
        . /etc/default/elasticsearch
fi

#Export /etc/default/elasticsearch variables, could be usefull for Ansible.
export ES_HOME
export CONF_DIR
export DATA_DIR  
export LOG_DIR
export ES_HEAP_SIZE
export ES_USER
export ES_GROUP
export MAX_OPEN_FILES
export MAX_LOCKED_MEMORY
export MAX_MAP_COUNT

# Check DAEMON exists
test -x $DAEMON || exit 0
#/usr/lib/jvm/java-8-oracle/jre/bin/java
checkJava() {
        if [ -x "$JAVA_HOME/bin/java" ]; then
                JAVA="$JAVA_HOME/bin/java"
        else
                JAVA=`which java`
        fi

        if [ ! -x "$JAVA" ]; then
                log_daemon_msg "Could not find any executable java binary. Please install java in your PATH or set JAVA_HOME"
                exit 1
        fi
}

case "$1" in
  start)
        log_daemon_msg "Starting $DESC"
        log_daemon_msg "Prepare JAVA environment... "
        checkJava
        log_daemon_msg "OK, JAVA environment ready : $JAVA"
        log_daemon_msg "Prepare Elasticsearch environment... "

        if [ -n "$MAX_LOCKED_MEMORY" -a -z "$ES_HEAP_SIZE" ]; then
                log_failure_msg "MAX_LOCKED_MEMORY is set - ES_HEAP_SIZE must also be set"
                exit 1
        fi

        pid=`pidofproc -p $PID_FILE elasticsearch`
        if [ -n "$pid" ] ; then
                log_begin_msg "PID Already running. Please check elasticsearch status in /var/run/elasticsearch"
                log_end_msg 0
                exit 0
        fi

        mkdir -p "$LOG_DIR" "$DATA_DIR" && chown "$ES_USER":"$ES_GROUP" "$LOG_DIR" "$DATA_DIR"
       
        # Ensure that the PID_DIR exists (it is cleaned at OS startup time)
        if [ -n "$PID_DIR" ] && [ ! -e "$PID_DIR" ]; then
                mkdir -p "$PID_DIR" && chown "$ES_USER":"$ES_GROUP" "$PID_DIR"
                log_daemon_msg "PID_DIR creation needed"
                log_end_msg 0
        fi
        
        log_daemon_msg "OK, PID_DIR : $PID_DIR"

        if [ -n "$PID_FILE" ] && [ ! -e "$PID_FILE" ]; then
                touch "$PID_FILE" && chown "$ES_USER":"$ES_GROUP" "$PID_FILE"
                log_daemon_msg "PID_FILE creation needed"
                log_end_msg 0
        fi

        log_daemon_msg "OK, PID_FILE : $PID_FILE"
        log_daemon_msg "OK, Elasticsearch environment ready "
        # Start Daemon
        log_daemon_msg "Starting Daemon : $DAEMON with ES_HEAP_SIZE=$ES_HEAP_SIZE"
        log_daemon_msg "... with : ES_HOME=$ES_HOME ; ES_USER=$ES_USER ; ES_GROUP=$ES_GROUP"
        log_daemon_msg "... with : CONF_DIR=$CONF_DIR ; DATA_DIR=$DATA_DIR  ; LOG_DIR=$LOG_DIR"
        log_daemon_msg "... with options : DAEMON_OPTS=$DAEMON_OPTS"
        start-stop-daemon -d $ES_HOME --start -b --user "$ES_USER" -c "$ES_USER" --pidfile "$PID_FILE" --exec $DAEMON -- $DAEMON_OPTS
        return=$?
        log_daemon_msg "LSB command start-stop-daemon ended with code $return"
        if [ $return -eq 0 ]; then
                i=0
                timeout=4
                timeoutduration=$(($timeout + 1))
                log_daemon_msg "Elasticsearch initializing...., timeout : $timeoutduration"
                # Wait for the process to be properly started before exiting
                until { kill -0 `cat "$PID_FILE"`; } >/dev/null 2>&1
                do
                        sleep 1
                        i=$(($i + 1))
                        log_daemon_msg "Elasticsearch initializing.... $i of $timeoutduration"
                        if [ $i -gt $timeout ]; then
                                log_daemon_msg "Elasticsearch initialization FAILED...."
                                log_daemon_msg "You should check Elasticsearch logs. Files are in $LOG_DIR"
                                log_daemon_msg "You should check JVM logs. hs_err_pid* files are in $ES_HOME"
                                log_daemon_msg "if previous log files don't spawn, try chown(ing) $ES_USER:$ES_GROUP to $CONF_DIR, $DATA_DIR, $LOG_DIR"
                                log_end_msg 1
                                exit 1
                        fi
                done
        fi
        log_daemon_msg "Elasticsearch initialized !"
        log_daemon_msg "OK ! You may browse log files in $LOG_DIR to check Elasticsearch node/cluster settings and status"
        log_daemon_msg "Dummy test : curl http://localhost:9200/, wait a couple of seconds to check connectivity"
        log_end_msg $return
        exit $return
        ;;
  stop)
        log_daemon_msg "Stopping $DESC"

        if [ -f "$PID_FILE" ]; then
                start-stop-daemon --stop --pidfile "$PID_FILE" \
                        --user "$ES_USER" \
                        --quiet \
                        --retry forever/TERM/20 > /dev/null
                if [ $? -eq 1 ]; then
                        log_progress_msg "$DESC is not running but pid file exists, cleaning up"
                elif [ $? -eq 3 ]; then
                        PID="`cat $PID_FILE`"
                        log_failure_msg "Failed to stop $DESC (pid $PID)"
                        exit 1
                fi
                rm -f "$PID_FILE"
        else
                log_progress_msg "(not running)"
        fi
        log_end_msg 0
        ;;
  status)
        status_of_proc -p $PID_FILE elasticsearch elasticsearch && exit 0 || exit $?
        ;;
  restart|force-reload)
        if [ -f "$PID_FILE" ]; then
                $0 stop
                sleep 1
        fi
        $0 start
        ;;

  *)
        log_success_msg "Usage: $0 {start|stop|restart|force-reload|status}"
        exit 1
        ;;
esac

exit 0