#!/bin/bash
dnf -y update
dnf -y install epel-release
dnf -y install dnf-plugins-core
#dnf config-manager --set-enabled PowerTools
#dnf config-manager --set-enabled powertools
dnf config-manager --set-enabled crb
dnf install -y subversion wget gcc-c++ gcc-gfortran imake libXt-devel \
    openmotif-devel libXpm-devel python-unversioned-command \
    bzip2-devel tcsh python3-scons expat-devel \
    perl-XML-Simple perl-XML-Writer patch perl-File-Slurp git \
    mesa-libGLU-devel cmake \
    boost-devel gsl-devel glibc-langpack-en \
    libtool which bc nano cmake3 xrootd-client-libs xrootd-client \
    make libXi-devel python3-future \
    emacs gdb mariadb xterm python3-devel boost-python3-devel fmt-devel \
    libtirpc-devel mariadb-devel python3-mysqlclient xrootd-devel xrootd-client-devel \
    libnsl2-devel qt5 qt5-qtx11extras qt5-devel \
    python3-sqlalchemy python3-ply python3-click \
    apptainer htgettoken osg-ca-certs pelican \
    gfal2-all gfal2-util-scripts gfal2-plugin-xrootd python3-gfal2 python3-gfal2-util
pip install mysql-connector-python rucio-clients
pip install -i https://test.pypi.org/simple/ gluex-rucio-policy-package
cd /usr/include
ln -s freetype2/freetype freetype
isDockerBuildkit(){
    local cgroup=/proc/1/cgroup
    test -f $cgroup && [[ "$(<$cgroup)" = *:cpuset:/docker/buildkit/* ]]
}
isKanikoBuild(){
    test ["$KANIKO_EXECUTOR"=="true"]
}
if isDockerBuildkit || isKanikoBuild; then source /gluex_install/gluex_prereqs_postprocessor.sh ; fi
