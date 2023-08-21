#!/bin/sh

var=$1
if [ $(expr "$var" % "2") -eq 0 ]; then
    echo "$1: Четное"
elif [ $(expr "$var" % "2") -ne 0 ]; then
    echo "$var: Не четное"
else
    echo "Не число"
fi
