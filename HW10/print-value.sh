#!/bin/bash
if [ $1 ]; then
    VALUE=$1
    echo $VALUE

elif [ $VALUE ]; then
    echo "$VALUE"

else
    echo "VALUE не установлено"

fi
