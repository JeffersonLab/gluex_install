#!/bin/bash
apt-get update
apt-get -y install locales
locale-gen en_US
apt-get -y install gfortran xutils-dev libxt-dev libxft-dev \
    libmotif-dev libxpm-dev libxext-dev \
    libgl1-mesa-dev libmysqlclient-dev tcsh libbz2-dev scons \
    libxml-simple-perl libxml-writer-perl libfile-slurp-perl git cmake \
    python-dev libglu1-mesa-dev qt5-default libxmu-dev libboost-dev \
    libboost-python-dev libxi-dev libgsl-dev wget autoconf libtool curl g++ \
    libtirpc-dev python3-future

cd /usr/bin; ln -s make gmake

cd /usr/include # for cernlib
for file in ft2build.h config freetype.h fttypes.h ftsystem.h ftimage.h \
    fterrors.h ftmoderr.h fterrdef.h
do
    ln -s freetype2/$file .
done

cd /usr/include/freetype2 ; ln -s ../freetype2 freetype # for ROOT
