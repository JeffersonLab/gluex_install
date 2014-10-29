#!/bin/bash
mkdir -p gluex
pushd gluex
svn checkout https://halldsvn.jlab.org/repos/trunk/scripts/build_scripts
pwd_string=`pwd`
export GLUEX_TOP=$pwd_string
export BUILD_SCRIPTS=$GLUEX_TOP/build_scripts
echo export GLUEX_TOP=$pwd_string > setup.sh
echo source \$GLUEX_TOP/build_scripts/gluex_env.sh >> setup.sh
echo setenv GLUEX_TOP $pwd_string > setup.csh
echo source \$GLUEX_TOP/build_scripts/gluex_env.csh >> setup.csh
rm -fv version.xml
wget --no-check-certificate https://halldweb1.jlab.org/dist/version.xml
eval `$BUILD_SCRIPTS/version.pl -sbash version.xml`
source $BUILD_SCRIPTS/gluex_env.sh
echo ++++++++++++++++++++++++++++++++++++++++++DEBUG++++++++++++++++++++++++
printenv
make -f $BUILD_SCRIPTS/Makefile_all gluex
popd
