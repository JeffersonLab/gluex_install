#!/bin/bash
# GI_PATH is the fully qualified directory that contains this script
gi_script="${BASH_SOURCE[0]}";
if([ -h "${gi_script}" ]) then
  while([ -h "${gi_script}" ]) do gi_script=`readlink "${gi_script}"`; done
fi
pushd . > /dev/null
cd `dirname ${gi_script}` > /dev/null
GI_PATH=`pwd`
popd  > /dev/null
source gluex_env_boot.sh
gxenv
make -f $BUILD_SCRIPTS/Makefile_all gluex_pass1
if [ $? -ne 0 ]
then
    echo pass 1 failed, exiting
    exit 1
fi
gxenv
make -f $BUILD_SCRIPTS/Makefile_all gluex_pass2
