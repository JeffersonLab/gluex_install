#!/bin/sh
yum -y install epel-release
file=prereqs_redhat.sh
if [ ! -f $file ]
    then
    echo $file not found in current directory
    exit 1
fi
./$file
yum -y install lapack-static blas-static
