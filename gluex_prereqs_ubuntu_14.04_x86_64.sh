#!/bin/bash
apt-get -y install subversion g++ gfortran xutils-dev libxt-dev libxft-dev \
    liblapack-dev libblas-dev libmotif-dev dpkg-dev libxpm-dev libxext-dev \
    expect libgl1-mesa-dev libmysqlclient-dev tcsh libbz2-dev
cd /usr/bin; ln -s make gmake
cd /usr/include
for file in ft2build.h config freetype.h fttypes.h ftsystem.h ftimage.h \
    fterrors.h ftmoderr.h fterrdef.h
do
    ln -s freetype2/$file .
done
