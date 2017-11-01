#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

# APP LIST
APP_LIST=(
    build-essential 
    cmake
    cron
    dconf-editor
    espeak
    exfat-fuse
    exfat-utils
    expect
    fbi
    feh
    g++
    gcc
    gnome-schedule
    git
    gksu
    gparted
    gzip
    htop
    mplayer2
    netcat
    nmap
    npm
    ntp
    omxplayer
    openssh-client
    openssh-server
    openvpn    
    packeth
    pavucontrol
    pkg-config
    pure-ftpd
    python-dev
    python3-dev
    python-picamera 
    python3-picamera
    python-pip
    python3-pip
    screen
    sqlite3
    ssh
    sshfs
    tcpdump
    telnet
    tree
    tmux
    unzip
    vim
    vlc
    wget
    wireshark
    xclip
    youtube-dl
)

apt_update()
{
    echo "update..."
    apt-get update
}

main()
{
    apt_update
    clear

    if [[ -z $1 ]]; then
        echo "No command provided"
        install_app
    else
        case "$1" in
            "install")
                install_app
                ;;
            "all")
                remove_stuff
                install_app
                configure_misc
                git_config
                setup_vim
                ;;
        esac
    fi
}

remove_stuff()
{
    # Remove unused folders
    rm -rf ~/Templates
    rm -rf ~/Examples
    sudo apt-get purge wolfram-engine -y
}

install_app()
{
    echo "Installing apps now ..."
    sudo apt-get -y install "${APP_LIST[@]}"
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

git_config() {
    git config --global user.name "Waleed Khan"
    git config --global user.email "wqkhan@uwaterloo.ca"
    #git config --global push.default matching
}

configure_misc()
{
    echo "Give user privelages for wireshark"
    sudo dpkg-reconfigure wireshark-common
    echo "a wireshark group been created in /etc/gshadow. so add user to it"
    sudo gpasswd -a $USER wireshark
}

main "$@"