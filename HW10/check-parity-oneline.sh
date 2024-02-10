#!/bin/bash
var=$1
remainder=$(expr $var % 2)
case $remainder in
0)
    echo "$var - четное"
    ;;
1 | -1)
    echo "$var - нечетное"
    ;;
*)
    echo "$var - это не число"
    ;;
esac
