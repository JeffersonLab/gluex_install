#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
export GLUEX_INSTALL_HOME=$SCRIPT_DIR

# useful aliases & commands
#alias gluex_releases='eval "$(python gluex_releases.py $@)"'
gluex_releases() { if [ "$1" == "config" ]; then eval "$(python $GLUEX_INSTALL_HOME/gluex_releases.py $1 $2)"; else current_dir=$PWD;cd $GLUEX_INSTALL_HOME; python gluex_releases.py "$@";cd $current_dir; fi }
