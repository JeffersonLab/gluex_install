#!/bin/sh
yum install -y subversion make wget gcc-c++ gcc-gfortran imake libXt-devel \
    openmotif-devel lapack-devel blas-devel libXpm-devel expect mysql-devel \
    bzip2-devel tcsh
cd /usr/include ; ln -s freetype2/freetype freetype
