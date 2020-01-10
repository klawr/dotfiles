#!/usr/bin/zsh

strPDF=$(ls ~/Desktop/ | grep .pdf)
arrPDF=($(echo $strPDF | tr "\n" "\n"))
strFilPDF=${(M)arrPDF:#$1*}
arrFilPDF=($(echo $strFilPDF | tr "\n" "\n"))

if [ ${#arrFilPDF} -gt 1 ]
then
    green=`tput setaf 2`
    reset=`tput sgr0`
    echo -e "Filter ambiguous: ${green}$strFilPDF${reset}"
else
    mv ~/Desktop/$arrFilPDF[1] ~/safehaven/Documents/ml/
fi
