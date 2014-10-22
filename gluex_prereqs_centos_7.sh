#!/bin/sh
yum -y install epel-release
./prereqs_redhat.sh
yum -y install lapack-static blas-static
