#!/bin/bash
apt-get -y install subversion g++ gfortran xutils-dev libxt-dev libxft-dev \
    libatlas-base-dev libmotif-dev dpkg-dev libxpm-dev libxext-dev \
    expect libgl1-mesa-dev libmysqlclient-dev tcsh libbz2-dev
cd /usr/bin; ln -s make gmake
cd /usr/include; ln -s freetype2/freetype freetype
