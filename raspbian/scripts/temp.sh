
#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

config_dir()
{
    # Remove unused folders
    rm -rf ~/Templates
    rm -rf ~/Examples
    sudo apt-get purge wolfram-engine -y
    mkdir -p ~/Documents/git
    mkdir -p ~/Downloads
    mkdir -p ~/Pictures
    mkdir -p ~/Videos
}

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
 
 setup_vim()
{
    BUNDLE="$HOME/.vim/bundle"
    if [ ! -d "$BUNDLE/Vundle.vim" ]; then
        mkdir -p "$BUNDLE"
        git clone https://github.com/VundleVim/Vundle.vim.git "$BUNDLE/Vundle.vim"
    fi

    # Update existing (or new) installation
    cd "$BUNDLE/Vundle.vim"
    git pull -q
    # In order to update Vundle.vim and all your plugins directly from the command line you can use a command like this:
    vim -c VundleInstall -c quitall

    echo "Vim setup updated."
}

config_dir
update_config
setup_vim