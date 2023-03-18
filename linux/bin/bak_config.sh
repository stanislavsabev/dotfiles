# #!/usr/bin/env bash
#
# Copy all dotfiles to the .dotfiles/ directory in order to
# archivate the changes. 

echo WIP
return;

usage() {
    echo "usage: bak_config"
}

SCRIPTPATH="$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )"
readonly DEST="$(dirname "${SCRIPTPATH}/..")"

echo "SCRIPTPATH: $SCRIPTPATH"
