FROM ubuntu:16.04
MAINTAINER Lingcao Huang <huanglingcao@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install -y --install-recommends \
    build-essential \
    cmake \
    git \
    tar

RUN apt-get install -y --install-recommends\
    libwxgtk3.0-dev \
    vim

#install default gdal on ubuntu 16.04 (default version is 1.11)
RUN apt-get install -y --install-recommends gdal-bin libgdal-dev \
    proj-bin  libproj-dev

RUN mkdir /home/root
ENV HOME /home/root
WORKDIR $HOME

COPY saga-7.1.1.tar.gz /home/root/saga-7.1.1.tar.gz

RUN tar zxvf saga-7.1.1.tar.gz 
RUN cd saga-7.1.1 && ./configure  && make -j 8 && make install

# Clean-up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN rm -r saga-7.1.1 saga-7.1.1.tar.gz

