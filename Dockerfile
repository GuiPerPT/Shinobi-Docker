FROM ubuntu
MAINTAINER ulisses
RUN apt-get update && apt-get -y upgrade && apt-get install -y apt-utils && apt-get install -y software-properties-common && apt-get install sudo git parallel wget -y

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

## CONFIG SHINOBI
RUN cd / && git clone https://gitlab.com/Shinobi-Systems/Shinobi.git shinobi && cd shinobi && chmod +x INSTALL/ubuntu.sh && INSTALL/ubuntu.sh

## DEPENDENCIES SHINOBI
RUN apt-get install ffmpeg


## MORE SHINOBI CONFIG
RUN cd /shinobi && npm install
COPY conf.json /shinobi/conf.json

#IMPORT DATABASE
RUN apt-get install screen -y 
RUN mkdir /installation && mkdir -p /var/run/mysqld
COPY shinobi.sql /installation/shinobi.sql

##START CONTAINER

ENTRYPOINT ["/sbin/entrypoint.sh"]

CMD parallel ::: '/usr/bin/mysqld_safe --skip-grant-tables' 'cd /shinobi && INSTALL/start.sh' 'sleep 10 && mysql --execute="CREATE DATABASE IF NOT EXISTS ccio;" && mysql ccio < /installation/shinobi.sql'

