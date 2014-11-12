#!/bin/sh
yum install -y subversion wget gcc-c++ gcc-gfortran imake libXt-devel \
    openmotif-devel lapack-devel blas-devel libXpm-devel expect mysql-devel \
    bzip2-devel tcsh scons expat-devel lapack-static blas-static perl-XML-Simple
cd /usr/include
ln -s freetype2/freetype freetype
cd /usr/lib64
ln -s -v liblapack.a liblapack3.a
ln -s -v libblas.a libblas3.a
