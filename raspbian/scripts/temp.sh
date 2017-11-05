
#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_DIR="$(dirname "$SCRIPT_DIR")"


update_config()
 {
     if [ -f $HOME"/.vimrc" ] ; then
         rm $HOME"/.vimrc"
     fi
     cp $REPO_DIR"/config/vim/vimrc" $HOME"/.vimrc"
 
     if [ -f $HOME"/.tmux.conf" ] ; then
         rm $HOME"/.tmux.conf"
     fi
     cp $REPO_DIR"/config/tmux/tmux.conf" $HOME"/.tmux.conf"
 }

 update_config