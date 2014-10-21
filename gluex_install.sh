#!/bin/bash
mkdir -p gluex
pushd gluex
svn checkout https://halldsvn.jlab.org/repos/trunk/scripts/build_scripts
pwd_string=`pwd`
echo export GLUEX_TOP=$pwd_string > setup.sh
echo source \$GLUEX_TOP/build_scripts/gluex_env.sh >> setup.sh
echo setenv GLUEX_TOP $pwd_string > setup.csh
echo source \$GLUEX_TOP/build_scripts/gluex_env.csh >> setup.csh
source setup.sh
make -f $BUILD_SCRIPTS/Makefile_all gluex
popd
