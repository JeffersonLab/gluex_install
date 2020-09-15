#!/bin/bash
dist_token=$1
gluex_prereqs_script=$2

container_meta_dir=/beach/singularity/containers
gluex_install_dir=/home/marki/git/gluex_install
recipe_dir=$gluex_install_dir/singularity/recipes

recipe=$recipe_dir/Singularity.$dist_token
raw_sandbox=$container_meta_dir/$dist_token
gluex_sandbox=$container_meta_dir/gluex_$dist_token
gluex_sif=$container_meta_dir/gluex_$dist_token.sif

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

if [ -d $gluex_sif ]
then
    echo gluex simg $gluex_sif exists, exiting
    exit 1
fi
singularity build $gluex_sif $gluex_sandbox


