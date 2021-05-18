#!/bin/sh
yum install -y subversion wget gcc-c++ gcc-gfortran imake libXt-devel \
    openmotif-devel libXpm-devel mysql-devel \
    bzip2-devel tcsh scons expat-devel \
    perl-XML-Simple perl-XML-Writer patch perl-File-Slurp git \
    mesa-libGLU-devel cmake python-devel qt-devel boost-devel gsl-devel \
    libtool which bc nano cmake3 libnsl2-devel python27 python3-future \
    boost-python3-devel hostname emacs
cd /usr/include
ln -s freetype2/freetype freetype
dnf install -y findutils
