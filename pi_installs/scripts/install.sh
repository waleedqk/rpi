#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

MYHOME="/home/${SUDO_USER}"

OPTS=`getopt -o cnth --long config,new-install,test,help -n 'parse-options' -- "$@"`

usage() { echo "Error - Usage: $0 [-c || --config] [-n || --new-install] [-t || --test] [-h || --help]" 1>&2; exit 1; }


if [ $? != 0 ] ; then echo "Failed parsing options." usage >&2 ; exit 1 ; fi

echo "$OPTS"
eval set -- "$OPTS"

while true; do
  case "$1" in
    -c | --config )         CONFIG=true;        shift ;;
    -n | --new-install )    NEW_INSTALL=true;   shift ;;
    -t | --test )           TEST=true;          shift ;;
    -h | --help )           HELP=true;          shift ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done


# APP LIST
APP_LIST=(
    cmake
    cron
    curl
    espeak
    fail2ban # blocks suspicious requests coming from the internet
    fbi # Display Images on Raspbian Command
    feh
    g++
    gcc
    git
    htop
    libav-tools #avconv
    mpg321 # cli audio player
    netcat
    nmap
    npm
    ntp
    omxplayer
    openssh-client
    openssh-server
    packeth
    raspi-gpio
    screen
    sqlite3
    ssh
    sshfs
    tcpdump
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


# PIP3 LIST
PIP3_LIST=(
	pytube
)

APP3_LIST=(
    python-dev
    python3-dev
    python3-gpiozero
    python-picamera 
    python3-picamera
    python-pip
    python3-pip
	python3-nmap
)

# Update the system
apt_update()
{
    echo "Update list of available packages"
    apt-get update
}


config_dir()
{
    # Remove unused folders
    rm -rf $MYHOME/Templates
    rm -rf $MYHOME/Examples
    sudo apt-get purge wolfram-engine -y
    sudo -u ${SUDO_USER} mkdir -p $MYHOME/Documents/git
    sudo -u ${SUDO_USER} mkdir -p $MYHOME/Downloads
    sudo -u ${SUDO_USER} mkdir -p $MYHOME/Pictures
    sudo -u ${SUDO_USER} mkdir -p $MYHOME/Videos
    sudo -u ${SUDO_USER} mkdir -p $MYHOME/Music
}


install_app()
{
    echo "Installing apps now ..."
    sudo apt-get -y install "${APP_LIST[@]}"
}


pip_update()
{
	echo "update..."
	apt-get update
	clear
	echo "update pip..."
	sudo -H pip3 install --upgrade pip
	sudo -H pip2 install --upgrade pip
}

install_python_modules()
{
    pip_update

     echo "Installing python apps now ..."
	sudo apt-get -y install "${APP3_LIST[@]}"

	echo "Installing pip3 apps"	
	sudo -H pip3 install "${PIP3_LIST[@]}"

	echo "Upgrading modules ..."
	sudo pip3 install --upgrade "${PIP3_LIST[@]}"
}


wireshark_config()
{
    echo "Give user privelages for wireshark"
    sudo dpkg-reconfigure wireshark-common
    echo "a wireshark group been created in /etc/gshadow. so add user to it"
    sudo gpasswd -a $SUDO_USER wireshark
}


git_config() {
    sudo -u ${SUDO_USER} git config --global user.name "Waleed Khan"
    sudo -u ${SUDO_USER} git config --global user.email "wqkhan@uwaterloo.ca"
    #git config --global push.default matching
}


vim_config()
{
    BUNDLE="$MYHOME/.vim/bundle"
    if [ ! -d "$BUNDLE/Vundle.vim" ]; then
        sudo -u ${SUDO_USER} mkdir -p "$BUNDLE"
        sudo -u ${SUDO_USER} git clone https://github.com/VundleVim/Vundle.vim.git "$BUNDLE/Vundle.vim"
    fi

    # Update existing (or new) installation
    cd "$BUNDLE/Vundle.vim"
    sudo -u ${SUDO_USER} git pull -q
    # In order to update Vundle.vim and all your plugins directly from the command line you can use a command like this:
    sudo -u ${SUDO_USER} vim -c VundleInstall -c quitall

    echo "Vim setup updated."

    if [ -f $MYHOME"/.vimrc" ] ; then
        rm $MYHOME"/.vimrc"
    fi
    sudo -u ${SUDO_USER} cp $REPO_DIR"/config/vim/vimrc" $MYHOME"/.vimrc"
}


tmux_config()
{

    if [ -f $MYHOME"/.tmux.conf" ] ; then
        rm $MYHOME"/.tmux.conf"
    fi
    sudo -u ${SUDO_USER} cp $REPO_DIR"/config/tmux/tmux.conf" $MYHOME"/.tmux.conf"
}



main()
{
    echo "Starting install procedure..."

    # -z string True if the string is null (an empty string)
    if [ ! -z "${HELP}" ]; then
        echo "Requesting help: "
        usage
    fi

    apt_update
    clear

    if [ ! -z "${NEW_INSTALL}" ]; then
        echo "Initializing a fresh install" 
        config_dir
        install_app
        install_python_modules
        git_config
        tmux_config
        vim_config
        wireshark_config
    fi

    if [ ! -z "${CONFIG}" ]; then
        echo "Initializing config" 
    fi

    if [ ! -z "${TEST}" ]; then
        echo "Initializing test" 
    fi
}


main