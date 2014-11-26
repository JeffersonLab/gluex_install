#!/bin/bash
apt-get -y install subversion g++ gfortran xutils-dev libxt-dev libxft-dev \
    liblapack-dev libblas-dev libmotif-dev dpkg-dev libxpm-dev libxext-dev \
    expect libgl1-mesa-dev libmysqlclient-dev tcsh libbz2-dev scons \
    libxml-simple-perl libxml-writer-perl libfile-slurp-perl

cd /usr/bin; ln -s make gmake

cd /usr/include # for cernlib
for file in ft2build.h config freetype.h fttypes.h ftsystem.h ftimage.h \
    fterrors.h ftmoderr.h fterrdef.h
do
    ln -s freetype2/$file .
done

cd /usr/include/freetype2 ; ln -s ../freetype2 freetype # for ROOT

cd /usr/lib
ln -s liblapack.a liblapack3.a
ln -s libblas.a libblas3.a
