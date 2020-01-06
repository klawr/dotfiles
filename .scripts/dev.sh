#!/usr/bin/zsh

devel='/home/'$(whoami)'/devel/'

if [ $# -eq 0 ]
then
    cd $devel
else
    strDevel=$(ls ~/devel)
    arrDevel=($(echo $strDevel | tr "\n" "\n"))
    strFilDevel=${(M)arrDevel:#$1*}
    arrFilDevel=($(echo $strFilDevel | tr "\n" "\n"))

    if [ ${#arrFilDevel} -gt 1 ]
    then
        green=`tput setaf 2`
        reset=`tput sgr0`
        echo -e "Filter ambiguous: ${green}$strFilDevel${reset}"
    fi

    cd $devel$arrFilDevel[1]
fi
