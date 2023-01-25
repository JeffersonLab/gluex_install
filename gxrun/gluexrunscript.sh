#!/usr/bin/env bash

if [ -d /group ]; then
  echo "I am running in singularity."
else
  echo "Something went wrong with setting up singularity! Abort."
  exit 0
fi

CMDLINE_ARGS=""
# prepare command line arguments for evaluation
for arg in "$@"; do
    CMDLINE_ARGS="${CMDLINE_ARGS} $arg"
done

echo "source /group/halld/Software/build_scripts/gluex_env_jlab.sh /group/halld/www/halldweb/html/halld_versions/version.xml"
source /group/halld/Software/build_scripts/gluex_env_jlab.sh /group/halld/www/halldweb/html/halld_versions/version.xml

echo $CMDLINE_ARGS
$CMDLINE_ARGS
