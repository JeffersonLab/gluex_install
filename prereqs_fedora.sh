#!/bin/sh
dnf install -y subversion wget gcc-c++ gcc-gfortran imake libXt-devel \
    openmotif-devel libXpm-devel expect mysql-devel \
    bzip2-devel tcsh scons expat-devel lapack-static blas-static \
    perl-XML-Simple perl-XML-Writer patch perl-File-Slurp boost-devel gsl-devel
cd /usr/include
ln -s freetype2/freetype freetype
