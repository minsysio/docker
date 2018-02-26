FROM        prom/prometheus:latest
MAINTAINER  lvi@minsys.io 

COPY config/prometheus.yml                  /etc/prometheus/prometheus.yml

EXPOSE     9090
VOLUME     [ "/prometheus" ]

EXPOSE     9090
VOLUME     [ "/prometheus" ]
WORKDIR    /prometheus
ENTRYPOINT [ "/bin/prometheus" ]
CMD        [ "-config.file=/etc/prometheus/prometheus.yml", \
             "-storage.local.path=/prometheus", \
             "-web.console.libraries=/etc/prometheus/console_libraries", \
             "-web.console.templates=/etc/prometheus/consoles" ]
