#!/bin/bash
mkdir -p gluex_top
pushd gluex_top
git clone https://github.com/jeffersonlab/build_scripts
pwd_string=`pwd`
export GLUEX_TOP=$pwd_string
export BUILD_SCRIPTS=$GLUEX_TOP/build_scripts
rm -fv setup.sh
echo export GLUEX_TOP=$pwd_string > setup.sh
echo export BUILD_SCRIPTS=\$GLUEX_TOP/build_scripts >> setup.sh
echo source \$BUILD_SCRIPTS/gluex_env_version.sh $pwd_string/version.xml >> setup.sh
rm -fv setup.csh
echo setenv GLUEX_TOP $pwd_string > setup.csh
echo setenv BUILD_SCRIPTS \$GLUEX_TOP/build_scripts >> setup.csh
echo source \$BUILD_SCRIPTS/gluex_env_version.csh $pwd_string/version.xml >> setup.csh
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
