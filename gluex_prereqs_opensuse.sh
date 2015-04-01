#!/bin/sh
zypper --non-interactive install make subversion wget gcc-c++ gcc-fortran \
    imake libXt-devel openmotif-devel lapack-devel blas-devel libXpm-devel \
    expect mysql-connector-c++-devel libbz2-devel tcsh patch libXp-devel scons \
    libmysqlclient-devel perl-XML-Writer perl-File-Slurp
cd /usr/include
ln -s freetype2/freetype freetype
cd /usr/lib64
ln -s liblapack.so liblapack3.so
ln -s libblas.so libblas3.so
