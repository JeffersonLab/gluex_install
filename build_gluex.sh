#!/bin/bash
if [ "$1" == "-h" ]
then
    cat <<EOF

usage: build_gluex.sh [-h] [version-set-file]

    -h: print this usage message
    version-set-file: name of version set file with absolute path or path
        relative to the current working directory

EOF
    exit 0
fi
version_set=$1
set --
if ! source gluex_env_boot.sh
then
    echo build_gluex.sh error: could not source gluex_env_boot.sh
    exit 1
fi
if [ ! -f $version_set ]
then
    echo build_gluex.sh error: could not find version set file $version_set
    exit 2
fi
gxenv $version_set
make -f $BUILD_SCRIPTS/Makefile_all gluex_pass1
if [ $? -ne 0 ]
then
    echo pass 1 failed, exiting
    exit 1
fi
gxenv $version_set
make -f $BUILD_SCRIPTS/Makefile_all gluex_pass2
