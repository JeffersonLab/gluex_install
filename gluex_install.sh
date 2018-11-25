#!/bin/bash
mkdir -p gluex_top
pushd gluex_top
pwd_string=`pwd`
if [ -e build_scripts ]
    then
    echo build_scripts already here, skip installation
else
    echo cloning build_scripts repository
    git clone https://github.com/jeffersonlab/build_scripts
    pushd build_scripts
    git checkout latest
    popd
fi
export GLUEX_TOP=$pwd_string
export BUILD_SCRIPTS=$GLUEX_TOP/build_scripts
rm -fv setup.sh
echo export GLUEX_TOP=$pwd_string > setup.sh
echo export BUILD_SCRIPTS=\$GLUEX_TOP/build_scripts >> setup.sh
echo source \$BUILD_SCRIPTS/gluex_env_version.sh $pwd_string/version_jlab.xml >> setup.sh
rm -fv setup.csh
echo setenv GLUEX_TOP $pwd_string > setup.csh
echo setenv BUILD_SCRIPTS \$GLUEX_TOP/build_scripts >> setup.csh
echo source \$BUILD_SCRIPTS/gluex_env_version.csh $pwd_string/version_jlab.xml >> setup.csh
if [ -f version_jlab.xml ]
    then
    echo version_jlab.xml exists, skip download
else
    echo getting version_jlab.xml from halldweb.jlab.org
    wget --no-check-certificate https://halldweb.jlab.org/dist/version_jlab.xml
fi
source setup.sh
make -f $BUILD_SCRIPTS/Makefile_all gluex_pass1
source $BUILD_SCRIPTS/gluex_env_clean.sh
source setup.sh
make -f $BUILD_SCRIPTS/Makefile_all gluex_pass2
popd
