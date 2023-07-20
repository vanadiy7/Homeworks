#!/usr/bin/bash
free -h | awk '/Mem/{print$1$4}' | sed -e 's/Gi/Гигабайт/g' -e 's/Mem:/Свободная оперативная память: /g';
cat /proc/loadavg | awk '{$1 = "Загрузка процессора:"; print $1 $2};';
hostname -I | awk {'$3 = "IP адресс:"; print $3 $1}';
