#!/bin/bash
[[ -p /dev/stdin ]] && {
    mapfile -t
    set -- "${MAPFILE[@]}"
}

for i in "$@"; do
    if [ -f $i ] && [ -s $i ]; then
        echo "$i"
    fi
done
