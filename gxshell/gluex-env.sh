#!/bin/sh
# taken from eic-shell

for i in /etc/profile.d/*.sh; do                                                                                                                                                                                                             
  if [ -r "$i" ]; then                                                                                                                                                                                                                       
    . "$i"                                                                                                                                                                                                                                   
  fi                                                                                                                                                                                                                                         
done                                                                                                                                                                                                                                         

## default PS1 preamble in case we can't find better info                                                                                                                                                                                    
export PS1='gxshell> \[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33'

## unset CURL_CA_BUNDLE and SSL_CERT_FILE if not accessible
## inside container: this addresses certain HPC systems where
## CURL_CA_BUNDLE and SSL_CERT_FILE are customized to point
## to paths that do not exist inside this container
if [ ! -r ${CURL_CA_BUNDLE:-/} ]; then
  unset CURL_CA_BUNDLE
fi
if [ ! -r ${SSL_CERT_FILE:-/} ]; then
  unset SSL_CERT_FILE
fi

## set CLING_STANDARD_PCH and CPPYY_API_PATH to `none` for cppyy
export CLING_STANDARD_PCH='none'
export CPPYY_API_PATH='none'

## redefine ls and less as functions, as this is something we
## can import into our plain bash --norc --noprofile session
## (aliases cannot be transferred to a child shell)
ls () {
  /bin/ls --color=auto "$@"
}
less () {
  /usr/bin/less -R "$@"
}
grep () {
  /bin/grep --color=auto "$@"
}
MYSHELL=$(ps -p $$ | awk '{print($4);}' | tail -n1)
## only export the functions for bash, as this does not work
## in all shells and we only care about bash here. Note that
## the singularity startup runs in plain sh which requires the
## if statement
if [ "$MYSHELL" = "bash" ]; then
  export -f ls
  export -f less
  export -f grep
fi
unset MYSHELL

## set up GlueX paths
export GLUEX_TOP="/group/halld/Software/builds/Linux_CentOS7-x86_64-gcc4.8.5-cntr/"
export BUILD_SCRIPTS="/group/halld/Software/build_scripts/"
export HALLD_VERSIONS="/group/halld/www/halldweb/html/halld_versions/"
## Welcome message
echo
echo
echo '##########################################'
echo '##  GGGGG  LL    UU   UU EEEEEE XX   XX ##'
echo '## GG      LL    UU   UU EE      XX XX  ##'
echo '## GG  GGG LL    UU   UU EEEEE    XXX   ##'
echo '## GG   GG LL    UU   UU EE      XX XX  ##'
echo '##  GGGGG  LLLLLL UUUUU  EEEEEE XX   XX ##'
echo '##########################################'
echo
echo 'Welcome to the GlueX shell!!'
echo 
echo 'GLUEX_TOP = '${GLUEX_TOP}
echo 'BUILD_SCRIPTS = '${BUILD_SCRIPTS}
echo 'attempting to set up environment based on '${HALLD_VERSIONS}/version.xml
echo
echo 'to bind directories for use within the singularity container use the --bind/-B option in the format src[:dest]'
echo '   e.g. singularity exec -B /scratch <container> gxshell'
echo '     or singularity exec -B /cvmfs/oasis.opensciencegrid.org/gluex/group/halld:/group/halld <container> gxshell'
echo 'or set environment variable SINGULARITY_BIND before entering the container'
echo '   e.g. export SINGULARITY_BIND="/scratch"'
echo
echo
## source software
source ${BUILD_SCRIPTS}/gluex_env_jlab.sh ${HALLD_VERSIONS}/version.xml
