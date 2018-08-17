#!/bin/bash
mkdir -p gluex_top
pushd gluex_top
if [ -e build_scripts ]
    then
    echo build_scripts already here, skip download
else
    echo downloading build_scripts tar file
    rm -rf build_scripts-latest latest.tar.gz build_scripts
    wget -O latest.tar.gz --no-check-certificate https://github.com/jeffersonlab/build_scripts/archive/latest.tar.gz
    tar zxf latest.tar.gz
    ln -s build_scripts-latest build_scripts
fi
if [ ! -z $1 ]; then
    version_file=$1
else
    version_file=version.xml
fi
version_name=${version_file%.*}
pwd_string=`pwd`
export GLUEX_TOP=$pwd_string
export BUILD_SCRIPTS=$GLUEX_TOP/build_scripts
mkdir -p setups
rm -fv setups/setup.$version_name.sh
echo export GLUEX_TOP=$pwd_string > setups/setup.$version_name.sh
echo export BUILD_SCRIPTS=\$GLUEX_TOP/build_scripts >> setups/setup.$version_name.sh
echo source \$BUILD_SCRIPTS/gluex_env_version.sh $pwd_string/$version_file >> setups/setup.$version_name.sh
rm -fv setups/setup.$version_name.csh
echo setenv GLUEX_TOP $pwd_string > setups/setup.$version_name.csh
echo setenv BUILD_SCRIPTS \$GLUEX_TOP/build_scripts >> setups/setup.$version_name.csh
echo source \$BUILD_SCRIPTS/gluex_env_version.csh $pwd_string/$version_file >> setups/setup.$version_name.csh
if [ -f $version_file ]
    then
    echo $version_file exists, skip download
else
    echo getting $version_file from halldweb.jlab.org
    wget --no-check-certificate https://halldweb.jlab.org/dist/$version_file
fi
source $BUILD_SCRIPTS/gluex_env_version.sh $version_file
# choose new or old-style builds depending on if sim-recon (HALLD_HOME) or halld_recon (HALLD_RECON_HOME) are set
if [ ! -z $2 ]; then
    build_target=$2
else
    if [ -z $HALLD_RECON_HOME ]; then
	build_target=gluex
    else
	build_target=gluex2
    fi
fi
# do the build
make -f $BUILD_SCRIPTS/Makefile_all $build_target
popd
