#!/bin/bash
mkdir -p gluex
pushd gluex
svn checkout https://halldsvn.jlab.org/repos/trunk/scripts/build_scripts
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
eval `$BUILD_SCRIPTS/version.pl -sbash version.xml`
source $BUILD_SCRIPTS/gluex_env.sh
make -f $BUILD_SCRIPTS/Makefile_all gluex
popd
