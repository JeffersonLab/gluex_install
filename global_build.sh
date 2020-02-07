#!/bin/bash
version_set_file=$1
echo global_build.sh: version set file = $version_set_file
build_dir=$2
echo global_build.sh: build directory = $build_dir
mkdir -p $build_dir
cd $build_dir
mkdir -p resources
if [ -e build_scripts ]
    then
    echo build_scripts already here, skip installation
else
    echo cloning build_scripts repository
    git clone https://github.com/jeffersonlab/build_scripts
    pushd build_scripts
    ./update_to_latest.sh
    popd
fi
if [ -e halld_versions ]
    then
    echo halld_versions already here, skip installation
else
    echo cloning halld_versions repository
    git clone https://github.com/jeffersonlab/halld_versions
fi
export GI_PATH=/home/marki/gluex_install
$GI_PATH/create_setup_scripts.sh $build_dir
. gluex_env_boot.sh
gxenv $version_set_file
make -f $BUILD_SCRIPTS/Makefile_all gluex_pass1
gxenv $version_set_file
make -f $BUILD_SCRIPTS/Makefile_all gluex_pass2
