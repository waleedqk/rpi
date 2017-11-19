#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

CUR_USER="/home/$(who -m | awk '{print $1;}')"

# APP LIST
APP_LIST=(
    build-essential 
    cmake
    cron
    curl
    dconf-editor
    espeak
    exfat-fuse
    exfat-utils
    expect
    fail2ban # blocks suspicious requests coming from the internet
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
    libav-tools #avconv
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
    python3-gpiozero
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
    xrdp # remote desktop application
    youtube-dl
)

NO_FLAGS=true

read_args()
{
    APPS_INSTALL=
    INSTALL_ALL=
    for arg in "$@"; do
        case $arg in
            -a)
                NO_FLAGS=false
                APPS_INSTALL="true";;
            -i)
                NO_FLAGS=false
                INSTALL_ALL="true";;
            *)
                echo "Usage: sudo script_name.bash -a | -i "
                NO_FLAGS="true";;                
        esac
    done
}

apt_update()
{
    echo "update..."
    apt-get update
}

main()
{
    apt_update
    apt-get upgrade
    clear

    if [ "$NO_FLAGS" = true ]; then
        echo "No flags provided"
        install_app
    else
        if [ -n "$INSTALL_ALL" ]; then
            echo "Fresh install"
            config_dir
            install_app
            configure_misc
            git_config
            update_config
            setup_vim
            permissions     
        elif   [ -n "$APPS_INSTALL" ]; then
            echo "Install apps only"
            install_app
        fi
    fi

}

config_dir()
{
    # Remove unused folders
    rm -rf $CUR_USER/Templates
    rm -rf $CUR_USER/Examples
    sudo apt-get purge wolfram-engine -y
    mkdir -p $CUR_USER/Documents/git
    mkdir -p $CUR_USER/Downloads
    mkdir -p $CUR_USER/Pictures
    mkdir -p $CUR_USER/Videos
}

install_app()
{
    echo "Installing apps now ..."
    sudo apt-get -y install "${APP_LIST[@]}"
}

update_config()
 {
     if [ -f $CUR_USER"/.vimrc" ] ; then
         rm $CUR_USER"/.vimrc"
     fi
     cp $REPO_DIR"/config/vim/vimrc" $CUR_USER"/.vimrc"
 
     if [ -f $CUR_USER"/.tmux.conf" ] ; then
         rm $CUR_USER"/.tmux.conf"
     fi
     cp $REPO_DIR"/config/tmux/tmux.conf" $CUR_USER"/.tmux.conf"
 }

setup_vim()
{
    BUNDLE="$CUR_USER/.vim/bundle"
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

permissions()
{
    sudo usermod -a -G adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,input,netdev,spi,i2c,gpio $(whoami)
}

install_webserver()
{
    # https://www.raspberrypi.org/documentation/remote-access/web-server/apache.md
    sudo apt-get install apache2 -y
    sudo apt-get install php7.0 php7.0-mysql mysql-server -y
}

read_args "$@"
main