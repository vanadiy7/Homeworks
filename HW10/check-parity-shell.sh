#!/bin/bash
var=$1
if [[ ! $var =~ ^[+-]?[0-9]+$ ]]; then
    echo "${var} - это не число"
elif [[ $((var % 2)) -eq 0 ]]; then
    echo "${var} - четная"
else
    echo "${var} - нечетная"
fi
