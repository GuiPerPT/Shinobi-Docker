FROM ubuntu
MAINTAINER ulisses
RUN apt-get update && apt-get -y upgrade && apt-get install -y apt-utils && apt-get install -y software-properties-common && apt-get update && apt-get install sudo ffmpeg x264 x265 nodejs npm git wget -y

# MYSQL CONFIG
ENV MYSQL_USER=mysql \
    MYSQL_VERSION=5.7.24 \
    MYSQL_DATA_DIR=/var/lib/mysql \
    MYSQL_RUN_DIR=/run/mysqld \
    MYSQL_LOG_DIR=/var/log/mysql \
    DB_USER=root \
    DB_PASS=root \
    DB_NAME=shinobi

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server \
 && rm -rf ${MYSQL_DATA_DIR} \
&& rm -rf /var/lib/apt/lists/*

## COPY ENTRYPOINT AND SET PERMISSIONS
COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

## COPY STARTER AND SET PERMISSIONS
COPY starter.sh /sbin/starter.sh
RUN chmod 755 /sbin/starter.sh

## CUSTOM SHINOBI EASY INSTALL AND CONF
COPY conf.json /installation/conf.json
COPY start.sh /installation/start.sh
COPY ubuntu.sh /installation/ubuntu.sh
RUN chmod +x /installation/ubuntu.sh && chmod +x /installation/start.sh

## PM2
RUN npm install pm2 -g

## VOLUMES
VOLUME /var/lib/mysql

ENTRYPOINT ["/sbin/entrypoint.sh"]

CMD ["/sbin/starter.sh"]
