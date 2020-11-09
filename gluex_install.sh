#!/bin/bash

while getopts "s:b:" arg
do
    case $arg in
	s)
	    default_version_set=$OPTARG
	    ;;
	b)
	    build_scripts_branch=$OPTARG
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
    command="$command -b $build_scripts_branch"
fi
if [ ! -z $default_version_set ]
then
    command="$command -s $default_version_set"
fi
echo info: executing $command
if ! $command
then
    echo error: could not create complete gluex_top
    exit 1
fi
cd gluex_top
$GI_PATH/build_gluex.sh
