#!/bin/bash
dist_token=$1
gluex_prereqs_script=$2

container_meta_dir=/beach/singularity/containers
recipe_dir=/beach/singularity/recipes
build_meta_dir=/fantom/scratch
gluex_install_dir=/home/marki/git/gluex_install

recipe=$recipe_dir/Singularity.$dist_token
raw_sandbox=$container_meta_dir/$dist_token
gluex_sandbox=$container_meta_dir/gluex_$dist_token
gluex_simg=$container_meta_dir/gluex_$dist_token.simg

if [ -d $raw_sandbox ]
then
    echo raw sandbox $raw_sandbox exists, exiting
    exit 1
fi
singularity build --sandbox $raw_sandbox $recipe

if [ -d $gluex_sandbox ]
then
    echo gluex sandbox $gluex_sandbox exists, exiting
    exit 1
fi
cp -pr $raw_sandbox $gluex_sandbox
singularity exec --writable $gluex_sandbox mkdir /gluex_install
singularity exec --bind $gluex_install_dir:/gluex_install --writable $gluex_sandbox /gluex_install/$gluex_prereqs_script

if [ -d $gluex_simg ]
then
    echo gluex simg $gluex_simg exists, exiting
    exit 1
fi
singularity build $gluex_simg $gluex_sandbox


