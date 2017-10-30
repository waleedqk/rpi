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
    python-dev
    python3-dev
    python-picamera 
    python3-picamera
    python-pip
    python3-pip
    screen
    sqlite3
    ssh
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

# https://www.pyimagesearch.com/2016/04/18/install-guide-raspberry-pi-3-raspbian-jessie-opencv-3/
OPENCV_LIST=(
    build-essential
    cmake 
    pkg-config
    libjpeg-dev 
    libtiff5-dev 
    libjasper-dev 
    libpng12-dev
    libavcodec-dev 
    libavformat-dev 
    libswscale-dev 
    libv4l-dev
    libxvidcore-dev 
    libx264-dev
    libgtk2.0-dev
    libatlas-base-dev 
    gfortran
    python2.7-dev 
    python3-dev
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
    git config --global user.email "waleedqk@gmail.com"
    #git config --global push.default matching
}

configure_misc()
{
    echo "Give user privelages for wireshark"
    sudo dpkg-reconfigure wireshark-common
    echo "a wireshark group been created in /etc/gshadow. so add user to it"
    sudo gpasswd -a $USER wireshark
}

install_opencv()
{
    sudo apt-get -y install "${OPENCV_LIST[@]}"
    cd ~
    wget -O opencv.zip https://github.com/Itseez/opencv/archive/3.3.1.zip
    unzip opencv.zip

    wget -O opencv_contrib.zip https://github.com/Itseez/opencv_contrib/archive/3.3.1.zip
    unzip opencv_contrib.zip

    cd ~
    rm opencv.zip
    rm opencv_contrib.zip

    sudo pip install virtualenv virtualenvwrapper
    sudo pip3 install virtualenv virtualenvwrapper
    sudo rm -rf ~/.cache/pip

    echo -e "\n# virtualenv and virtualenvwrapper" >> ~/.profile
    echo "export WORKON_HOME=$HOME/.virtualenvs" >> ~/.profile
    echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.profile
    source ~/.profile

    mkvirtualenv cv -p python3

    source ~/.profile
    workon cv

    pip install numpy
    pip3 install numpy

    cd ~/opencv-3.3.1/
    mkdir build
    cd build
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib-3.3.1/modules \
    -D BUILD_EXAMPLES=ON ..

    make

    sudo make install
    sudo ldconfig

    ls -l /usr/local/lib/python3.4/site-packages/

    cd /usr/local/lib/python3.4/site-packages/
    sudo mv cv2.cpython-34m.so cv2.so


    rm -rf ~/opencv-3.1.0 ~/opencv_contrib-3.1.0
}

main "$@"