#!/bin/bash
declare -a os=("Linux" "Window")
declare -a arch=("AMD_64" "AMD_32" "AMD_86_64")
length_os=${#os[@]}
length_arch=${#arch[@]}
for ((i = 0; i < $length_os; i++)); do
    for ((j = 0; j < $length_arch; j++)); do
        echo "${os[i]} - ${arch[j]}"
    done
done
