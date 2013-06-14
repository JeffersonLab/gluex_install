#!/bin/sh
yum update -y audit
yum install -y subversion wget gcc-c++ gcc-gfortran imake libXt-devel \
    motif-devel lapack-devel blas-devel libXpm-devel expect mysql-devel \
    bzip2-devel tcsh
cd /usr/include ; ln -s freetype2/freetype freetype
