#!/bin/bash
version_set=$1
set --
source gluex_env_boot.sh
gxenv $version_set
make -f $BUILD_SCRIPTS/Makefile_all gluex_pass1
if [ $? -ne 0 ]
then
    echo pass 1 failed, exiting
    exit 1
fi
gxenv $version_set
make -f $BUILD_SCRIPTS/Makefile_all gluex_pass2
