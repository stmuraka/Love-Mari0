FROM ubuntu:xenial
MAINTAINER Shaun Murakami <stmuraka@us.ibm.com>

# Add Love repository
RUN echo "deb http://ppa.launchpad.net/bartbes/love-stable/ubuntu `cat /etc/lsb-release | grep CODENAME | cut -d '=' -f2` main" > /etc/apt/sources.list.d/love.list \
 && echo "deb-src http://ppa.launchpad.net/bartbes/love-stable/ubuntu `cat /etc/lsb-release | grep CODENAME | cut -d '=' -f2` main" >> /etc/apt/sources.list.d/love.list \
 && apt-key adv --keyserver keyserver.ubuntu.com --recv F192197F81992645

# Install components
RUN apt-get -y update \
 && apt-get -y install \
        apt-utils \
        unzip \
        love \
        #pulseaudio \
# Cleanup package files
 && apt-get autoremove  \
 && apt-get autoclean

WORKDIR /root/
ARG GAME_DOWNLOAD
ENV GAME_DOWNLOAD ${GAME_DOWNLOAD:-"http://stabyourself.net/dl.php?file=mari0-1006/mari0-linux.zip"}
ADD ${GAME_DOWNLOAD} /root/

RUN mv dl.php $(basename ${GAME_DOWNLOAD}) \
 && unzip $(basename ${GAME_DOWNLOAD})

CMD love $(find . -name "*.love")
