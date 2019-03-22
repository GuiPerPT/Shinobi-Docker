FROM ubuntu
MAINTAINER ulisses
RUN apt-get update && apt-get -y upgrade && apt-get install -y apt-utils && apt-get install -y software-properties-common && apt-get install sudo git wget -y

RUN cd / && git clone https://gitlab.com/Shinobi-Systems/Shinobi.git shinobi && cd shinobi && chmod +x INSTALL/ubuntu.sh && INSTALL/ubuntu.sh
RUN apt-get install ffmpeg
RUN cd /shinobi && npm install
CMD cd /shinobi && INSTALL/start.sh
