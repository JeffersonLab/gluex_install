#!/bin/bash

gluex_top_dir=gluex_top
while getopts "s:b:t:" arg
do
    case $arg in
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
#
if [ -d $gluex_top_dir ]
then
    echo "create_gluex_top.sh error: $gluex_top_dir already exists, exiting"
    exit 1;
fi
mkdir -p $gluex_top_dir
pushd $gluex_top_dir
pwd_string=`pwd`
mkdir -p resources
if [ -e build_scripts ]
    then
    echo build_scripts already here, skip installation
else
    echo cloning build_scripts repository
    git clone https://github.com/jeffersonlab/build_scripts
    pushd build_scripts > /dev/null
    if [ -z $build_scripts_branch ]
    then
	./update_to_latest.sh
    else
	echo info: checking out branch $build_scripts_branch
	if ! git checkout $build_scripts_branch
	then
	    echo error: branch not checked out
	    cd ..
	    rm -rf build_scripts
	    exit 1
	fi
    fi
    popd > /dev/null
fi
if [ -e halld_versions ]
    then
    echo halld_versions already here, skip installation
else
    echo cloning halld_versions repository
    git clone https://github.com/jeffersonlab/halld_versions
fi
if [ $default_version_set ]
then
    if [ ! -e halld_versions/$default_version_set ]
    then
	echo error: default version set file halld_versions/$default_version_set not found
	exit 2
    fi
    echo create_gluex_top.sh info: default version set will be $default_version_set
fi
$GI_PATH/create_setup_scripts.sh $pwd_string $default_version_set
