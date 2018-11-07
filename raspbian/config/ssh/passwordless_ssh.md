# SSH Passwordless Login Using SSH

## 1) Create the .ssh directory on the rasp_pi

    mkdir -p ~/.ssh

## 2) Create a ssh_key from host

Generate a pair of public keys from the host from where you will log into the rasp_pi:

    mkdir -p ~/.ssh
    cd ~/.ssh
    ssh-keygen -t rsa -b 4096
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ras_pi

## 3) Upload Generated Public Keys to rasp_pi

Use SSH from server (host) and upload new generated public key on server rasp_pi under pi‘s .ssh directory as a file name authorized_keys.

    cat ~/.ssh/id_ras_pi.pub | ssh pi@raspberry.local 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys'

or alternatively 

    ssh-copy-id -i ~/.ssh/id_ras_pi pi@raspberry.local

## 4) Set SSH Permissions on rasp_pi

Due to different SSH versions on servers, we need to set permissions on .ssh directory and authorized_keys file.

    ssh pi@raspberry.local "chmod 700 ~/.ssh; chmod 640 ~/.ssh/authorized_keys"

## 5) SSH login passwordless

SSH into the rasp_pi without having to provide the password:

    ssh pi@raspberry.local

or if key needs to be specified:

    ssh -i ~/.ssh/id_ras_pi pi@raspberry.local