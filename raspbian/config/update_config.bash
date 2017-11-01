#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

update_config()
 {
     if [ -f $HOME"/.vimrc" ] ; then
         rm $HOME"/.vimrc"
     fi
     cp $SCRIPT_DIR"/vim/vimrc" $HOME"/.vimrc"
 
     if [ -f $HOME"/.tmux.conf" ] ; then
         rm $HOME"/.tmux.conf"
     fi
     cp $SCRIPT_DIR"/tmux/tmux.conf" $HOME"/.tmux.conf"
 }

 update_config