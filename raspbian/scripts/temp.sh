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

# Update the system
apt_update()
{
    echo "Update list of available packages"
    apt-get update
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


}


main