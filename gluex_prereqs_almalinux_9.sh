#!/bin/bash
dnf -y update
dnf -y install epel-release
dnf -y install dnf-plugins-core
#dnf config-manager --set-enabled PowerTools
#dnf config-manager --set-enabled powertools
dnf install -y subversion wget gcc-c++ gcc-gfortran imake libXt-devel \
    openmotif-devel libXpm-devel \
    bzip2-devel tcsh python3-scons expat-devel \
    perl-XML-Simple perl-XML-Writer patch perl-File-Slurp git \
    mesa-libGLU-devel cmake python3-devel \
    boost-devel gsl-devel \
    libtool which bc nano cmake3 xrootd-client-libs xrootd-client \
    make boost-python3-devel libXi-devel python3-future \
    emacs gdb mariadb xterm python3-devel boost-python3-devel fmt-devel \
    libtirpc-devel mysql-devel python3-mysqlclient
    #qt5-devel
    #python2
    #libnsl2-devel
cd /usr/include
ln -s freetype2/freetype freetype