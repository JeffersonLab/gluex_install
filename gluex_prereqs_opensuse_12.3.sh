#!/bin/sh
zypper --non-interactive install make subversion wget gcc-c++ gcc-fortran \
    imake libXt-devel openmotif-devel lapack-devel blas-devel libXpm-devel \
    expect mysql-connector-c++-devel libbz2-devel tcsh
cd /usr/include ; ln -s freetype2/freetype freetype
