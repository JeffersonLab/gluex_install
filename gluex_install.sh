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
if [ -e halld_versions ]
    then
    echo halld_versions already here, skip installation
else
    echo cloning halld_versions repository
    git clone https://github.com/jeffersonlab/halld_versions
fi
export GLUEX_TOP=$pwd_string
export BUILD_SCRIPTS=$GLUEX_TOP/build_scripts
rm -fv setup.sh
echo export GLUEX_TOP=$pwd_string > setup.sh
echo export BUILD_SCRIPTS=\$GLUEX_TOP/build_scripts >> setup.sh
echo export HALLD_VERSIONS=\$GLUEX_TOP/halld_versions >> setup.sh
echo source \$BUILD_SCRIPTS/gluex_env_version.sh \$HALLD_VERSIONS/version_jlab.xml >> setup.sh
rm -fv setup.csh
echo setenv GLUEX_TOP $pwd_string > setup.csh
echo setenv BUILD_SCRIPTS \$GLUEX_TOP/build_scripts >> setup.csh
echo setenv HALLD_VERSIONS \$GLUEX_TOP/halld_versions >> setup.csh
echo source \$BUILD_SCRIPTS/gluex_env_version.csh \$HALLD_VERSIONS/version_jlab.xml >> setup.csh
source setup.sh
make -f $BUILD_SCRIPTS/Makefile_all gluex_pass1
if [ $? -ne 0 ]
then
    echo pass 1 failed, exiting
    popd
    exit 1
fi
source $BUILD_SCRIPTS/gluex_env_clean.sh
source setup.sh
make -f $BUILD_SCRIPTS/Makefile_all gluex_pass2
popd
