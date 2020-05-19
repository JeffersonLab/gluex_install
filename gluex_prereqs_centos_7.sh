#!/bin/sh
yum -y install epel-release
yum install -y subversion wget gcc-c++ gcc-gfortran imake libXt-devel \
    openmotif-devel libXpm-devel mysql-devel \
    bzip2-devel tcsh scons expat-devel \
    perl-XML-Simple perl-XML-Writer patch perl-File-Slurp git \
    mesa-libGLU-devel cmake python-devel qt-devel boost-devel gsl-devel \
    libtool which bc nano cmake3 tbb-devel xrootd-client-libs xrootd-client
cd /usr/include
ln -s freetype2/freetype freetype
