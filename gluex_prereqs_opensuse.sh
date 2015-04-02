#!/bin/sh
zypper --non-interactive install make subversion gcc-c++ gcc-fortran \
    imake libXt-devel lapack-devel blas-devel libXpm-devel \
    expect libbz2-devel patch libXp-devel scons \
    libmysqlclient-devel perl-XML-Writer perl-File-Slurp
cd /usr/include
ln -s freetype2/freetype freetype
cd /usr/lib64
ln -s liblapack.so liblapack3.so
ln -s libblas.so libblas3.so
