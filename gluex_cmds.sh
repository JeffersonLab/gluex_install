#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
export GLUEX_INSTALL_HOME=$SCRIPT_DIR

# useful aliases
#alias gluex_releases='eval "$(python gluex_releases.py -B)"'
alias gluex_releases='python gluex_releases.py'
