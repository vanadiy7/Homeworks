#!/usr/bin/bash
free -h | awk '/Mem/{print$1$4}' | sed -e 's/Gi/Гигабайт/g' -e 's/Mem:/Свободная оперативная память: /g';
cat /proc/loadavg | awk '{$1 = "Загрузка процессора:"; print $1 $3};';
hostname -I | awk {'$3 = "IP адресс:"; print $3 $1}';
df -h | grep "/dev/sda2"| awk '{ $10="Свободное место в root ";print $10 $4}';
ps -u $USER o pid,user,command | wc -l | awk -v var=$USER {'print "количество процессов под " var ":"  $1'};
