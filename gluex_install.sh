#!/bin/bash

print_usage() {
    cat <<EOF
Usage: gluex_install.sh [-h] [-s DEFAULT_VERSION_SET] [-b BUILD_SCRIPTS_BRANCH]

Options:
  -h print this usage message
  -s default version set file for this gluex_top, must exist in
     \$HALLD_VERSIONS, if omitted version.xml will be used
  -b branch of build_scripts to be checked out, if omitted the latest
     tagged version will be checked out
  -t name for the GLUEX_TOP directory, if omitted gluex_top will be used
  -r re-use the GLUEX_TOP found, do not exit due to its existence.
  -u URL of the build_scripts repository

EOF
}

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color
info="${BLUE}gluex_install.sh ${GREEN}info${NC}"
warning="${BLUE}gluex_install.sh ${YELLOW}warning${NC}"
error="${BLUE}gluex_install.sh ${RED}error${NC}"

reuse_gluex_top_dir=false
while getopts "hs:b:t:ru:" arg
do
    case $arg in
	h|\?)
	    print_usage
	    exit 0
	    ;;
	s)
	    default_version_set=$OPTARG
	    ;;
	b)
	    build_scripts_branch=$OPTARG
	    ;;
	t)
	    gluex_top_dir=$OPTARG
	    ;;
	r)
	    reuse_gluex_top_dir=true
	    ;;
	u)
	    build_scripts_url=$OPTARG
	    ;;
    esac
done

# GI_PATH is the fully qualified directory that contains this script
gi_script="${BASH_SOURCE[0]}";
if([ -h "${gi_script}" ]) then
  while([ -h "${gi_script}" ]) do gi_script=`readlink "${gi_script}"`; done
fi
pushd . > /dev/null
cd `dirname ${gi_script}` > /dev/null
GI_PATH=`pwd`
popd  > /dev/null

unset BUILD_SCRIPTS # for gluex_install.sh, always use the local build_scripts
command=$GI_PATH/create_gluex_top.sh
if [ ! -z $build_scripts_branch ]
then
    echo -e ${info}: using branch $build_scripts_branch of build_scripts
    command="$command -b $build_scripts_branch"
fi
if [ ! -z $default_version_set ]
then
    echo -e ${info}: using $default_version_set as the default version set
    command="$command -s $default_version_set"
fi
if [ ! -z $gluex_top_dir ]
then
    echo -e ${info}: $gluex_top_dir will be GLUEX_TOP
    command="$command -t $gluex_top_dir"
else
    gluex_top_dir=gluex_top
fi
if [ "$reuse_gluex_top_dir" = "true" ]
then
    command="$command -r"
fi
if [ ! -z $build_scripts_url ]
then
    echo -e ${info}: checkout out build_scripts from $build_scripts_url
    command="$command -u $build_scripts_url"
fi
echo -e ${info}: executing $command
if ! $command
then
    echo -e ${error}: could not create complete gluex_top
    exit 1
fi
cd $gluex_top_dir
$GI_PATH/build_gluex.sh
echo -e ${info}: done
