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

EOF
}

while getopts "hs:b:t:" arg
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
command=$GI_PATH/create_gluex_top.sh
if [ ! -z $build_scripts_branch ]
then
    echo gluex_install.sh info: using branch $build_scripts_branch of build_scripts
    command="$command -b $build_scripts_branch"
fi
if [ ! -z $default_version_set ]
then
    echo gluex_install.sh info: using $default_version_set as the default version set
    command="$command -s $default_version_set"
fi
if [ ! -z $gluex_top_dir ]
then
    echo gluex_install.sh info: $gluex_top_dir GLUEX_TOP will be GLUEX_TOP
    command="$command -t $gluex_top_dir"
else
    $gluex_top_dir=gluex_top
fi
echo gluex_install.sh info: executing $command
if ! $command
then
    echo error: could not create complete gluex_top
    exit 1
fi
cd $gluex_top_dir
$GI_PATH/build_gluex.sh
