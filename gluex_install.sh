#!/bin/bash
mkdir gluex
pushd gluex
svn checkout https://halldsvn.jlab.org/repos/trunk/scripts/build_scripts
echo export GLUEX_TOP=`pwd` > setup.sh
echo source \$GLUEX_TOP/build_scripts/gluex_env.sh >> setup.sh
source setup.sh
make -f $BUILD_SCRIPTS/Makefile_all
popd
