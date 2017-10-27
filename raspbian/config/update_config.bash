#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

UBUNTU_CODENAME=$(lsb_release -s -c)	#Xenial
UBUNTU_VERSION=$(lsb_release -rs)	#16.04

# APP LIST
APP_LIST=(
    arandr
    arc-theme
    atom
    build-essential
    cifs-utils
    clang
    clang-format
    cmake
    compton
    cron
    dconf-editor
    dkms
    docker-ce
    espeak
    exfat-fuse
    exfat-utils
    expect
    feh
    fontconfig-infinality
    fonts-font-awesome
    g++
    gcc
    git
    gksu
    gnome-icon-theme-full
    gparted
    gpsprune
    gzip
    handbrake-gtk
    handbrake-cli
    htop
    i3
    i3blocks
    inkscape
    lxappearance
    mc
    minecraft-installer
    moka-icon-theme faba-icon-theme faba-mono-icons
    netcat
    nmap
    npm
    ntp
    openssh-client
    openssh-server
    openvpn
    packeth
    pavucontrol
    python-pip
    python3-pip
    rofi
    screen
    shutter
    spotify-client
    sqlite3
    ssh
    steam
    synaptic
    syncthing
    tcpdump
    #terminator
    telnet
    texlive-full
    texstudio
    thunar
    tree
    tmux
    ubuntu-restricted-extras
    vim
    virtualbox
    vlc
    wireshark
    xclip
    #xrandr
    youtube-dl
)

# This list is specifically for plugin packages for the Atom text editor
ATOM_PACKAGES=(
    atom-beautify
    autocomplete-clang
    busy-signal
    clang-format
    git-time-machine
    highlight-selected
    intentions
    linter
    linter-ui-default
    linter-clang
    linter-shellcheck
    linter-cpplint
    language-lua
    language-cmake
    markdown-pdf
    minimap
    pigments
    remote-edit
)

apt_update()
{
    echo "update..."
    apt-get update
}

main_16()
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
            "ppa")
                add_16_ppa
                install_app
                ;;
            "all")
                remove_stuff
                add_16_ppa
                install_app
                install_gchrome
                configure_16
                git_config
                setup_vim
                # for atom-beautify
                pip install beautysh
                pip3 install beautysh
                install_atom_packages "${ATOM_PACKAGES[@]}"
                ;;
        esac
    fi
    #install_ros
}

add_16_ppa()
{
    echo "Adding PPAs"

    sudo add-apt-repository "deb http://archive.canonical.com/ubuntu $(lsb_release -sc) partner"

    # terminator terminal
    #add-apt-repository ppa:gnome-terminator/ppa -y

    # open source video transcoder
    sudo add-apt-repository ppa:stebbins/handbrake-releases -y

    # shutter
    sudo add-apt-repository ppa:shutter/ppa

    # minecraft
    sudo add-apt-repository -y ppa:minecraft-installer-peeps/minecraft-installer

    # atom
    sudo add-apt-repository -y ppa:webupd8team/atom

    # Syncthing
    curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
    echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list

    # Docker
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

    # Spotify
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
    echo 'deb http://repository.spotify.com stable non-free' | sudo tee /etc/apt/sources.list.d/spotify.list

    # Infinality (font renderer) http://www.webupd8.org/2013/06/better-font-rendering-in-linux-with.html
    sudo add-apt-repository ppa:no1wantdthisname/ppa -y

    # Arc Dark theme
    wget -nv https://download.opensuse.org/repositories/home:Horst3180/xUbuntu_16.04/Release.key -O Release.key
    sudo apt-key add - < Release.key
    sudo apt-get update
    sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_16.04/ /' > /etc/apt/sources.list.d/arc-theme.list"

    # Moka icon
    sudo add-apt-repository ppa:moka/daily -y

    echo "Updating package lists ..."
    sudo apt-get update -qq

}

install_app()
{
    echo "Installing apps now ..."
    sudo apt-get -y install "${APP_LIST[@]}"
}

remove_stuff()
{
    # Remove unused folders
    rm -rf ~/Templates
    rm -rf ~/Examples
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

configure_16()
{
    echo "Give user privelages for wireshark"
    sudo dpkg-reconfigure wireshark-common
    echo "a wireshark group been created in /etc/gshadow. so add user to it"
    sudo gpasswd -a $USER wireshark

    # add the vundle repo to vim
    # mkdir -p ~/.vim/bundle
    # git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
}

install_gchrome()
{
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
    sudo apt-get update
    sudo apt-get install google-chrome-stable -y
}

install_atom_packages()
{
    ARRAY=("$@")
    for atmpkg in "${ARRAY[@]}"; do
        if [[ ! -d "$HOME/.atom/packages/$atmpkg" ]]; then
            apm install "$atmpkg"
        else
            echo "atom package $atmpkg is already installed"
        fi
    done
}

install_ros()
{
    UBUNTU_CODENAME=$(lsb_release -s -c)
    case $UBUNTU_CODENAME in
        trusty)
            ROS_DISTRO=indigo ;;
        xenial)
            ROS_DISTRO=kinetic ;;
        *)
            echo "Unsupported version of Ubuntu detected. Only trusty (14.04.*) and xenial (16.04.*) are currently supported."
            exit 1
    esac

    sudo sh -c "echo \"deb http://packages.ros.org/ros/ubuntu $UBUNTU_CODENAME main\" > /etc/apt/sources.list.d/ros-latest.list"
    wget -qO - http://packages.ros.org/ros.key | sudo apt-key add -

    echo "Updating package lists ..."
    sudo apt-get -qq update

    echo "Installing ROS $ROS_DISTRO ..."
    sudo apt-get -qq install ros-$ROS_DISTRO-desktop python-rosinstall > /dev/null

    source /opt/ros/$ROS_DISTRO/setup.bash

    # Prepare rosdep to install dependencies.
    echo "Updating rosdep ..."
    if [ ! -d /etc/ros/rosdep ]; then
        sudo rosdep init > /dev/null
    fi
    rosdep update > /dev/null
}

case $UBUNTU_CODENAME in
    trusty)
        main_14 ;;
    xenial)
        (main_16 "$@") ;;
    *)
        echo "Unsupported version of Ubuntu detected. Only trusty (14.04.*) and xenial (16.04.*) are currently supported."
        exit 1 ;;
esac
