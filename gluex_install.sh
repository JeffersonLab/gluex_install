#!/bin/bash
mkdir -p gluex_top
pushd gluex_top
wget --no-check-certificate https://halldweb.jlab.org/dist/build_scripts.tar.gz
tar zxvf build_scripts.tar.gz
pwd_string=`pwd`
export GLUEX_TOP=$pwd_string
export BUILD_SCRIPTS=$GLUEX_TOP/build_scripts
rm -fv setup.sh
echo export GLUEX_TOP=$pwd_string > setup.sh
echo source \$GLUEX_TOP/build_scripts/gluex_env.sh >> setup.sh
rm -fv setup.csh
echo setenv GLUEX_TOP $pwd_string > setup.csh
echo source \$GLUEX_TOP/build_scripts/gluex_env.csh >> setup.csh
if [ -f version.xml ]
    then
    echo version.xml exists
else
    echo getting version.xml from halldweb
    wget --no-check-certificate https://halldweb.jlab.org/dist/version.xml
fi
source $BUILD_SCRIPTS/gluex_env_version.sh
make -f $BUILD_SCRIPTS/Makefile_all gluex
popd
