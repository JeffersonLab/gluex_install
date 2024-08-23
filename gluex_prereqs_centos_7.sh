#!/bin/bash
yum -y install epel-release
yum install -y subversion wget gcc-c++ gcc-gfortran imake libXt-devel \
    openmotif-devel libXpm-devel mariadb-devel \
    bzip2-devel tcsh scons expat-devel MySQL-python \
    perl-XML-Simple perl-XML-Writer patch perl-File-Slurp git \
    mesa-libGLU-devel cmake python-devel qt-devel boost-devel gsl-devel \
    libtool which bc nano cmake3 tbb-devel xrootd-client-libs xrootd-client \
    libtirpc-devel emacs python2-future gdb mariadb xterm python3-devel \
    boost-python36-devel fmt-devel qt5-qtbase-devel xload xclock xeyes xev gedit
cd /usr/include
ln -s freetype2/freetype freetype
yum install -y centos-release-scl
yum install -y devtoolset-8

source /gluex_install/gluex_prereqs_postprocessor.sh
