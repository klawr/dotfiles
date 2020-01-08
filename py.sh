#!/usr/bin/zsh

if [ $# -eq 0 ]
then
    . 'env/bin/activate'
else
    . $1'/bin/activate'
fi
