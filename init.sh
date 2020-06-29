#!/usr/bin/env bash

set -eu
set -o pipefail


cd "$(dirname "$0")" || exit 1

VIMPLUG_REMOTE='https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
VIMPLUG_HOME='autoload/plug.vim'
curl --location --create-dirs --output "$VIMPLUG_HOME" -- "$VIMPLUG_REMOTE"

PIP_HOME='vars/pip_modules'
yes | pip3 install --upgrade --target "$PIP_HOME" -- pynvim