#!/bin/bash

check_machine(){
    unameOut="$(uname -s)"
    case "${unameOut}" in
        Linux*)     machine=Linux;;
        Darwin*)    machine=Mac;;
        CYGWIN*)    machine=Cygwin;;
        MINGW*)     machine=MinGw;;
        *)          machine="UNKNOWN:${unameOut}"
    esac
    echo "You have ${machine} "
}
install(){
if [ "$(uname)" == "Darwin" ]; then
    if [[ $EUID -ne 0 ]]; then
            echo "This script must be run as root"
            exit 1
    fi
    sudo port install rtl-sdr 
    echo "-"
    echo "We will check if it works"       
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    if [[ $EUID -ne 0 ]]; then
            echo "This script must be run as root"
            exit 1
    fi
    apt-get install rtl-sdr
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    echo "Visit this http://www.rtl-sdr.com/getting-the-rtl-sdr-to-work-on-windows-10/"
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    echo "Visit this http://www.rtl-sdr.com/getting-the-rtl-sdr-to-work-on-windows-10/"
fi
}
check_installation(){
    rtl_test || echo "Error with your installation"
}
