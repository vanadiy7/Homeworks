#!/usr/bin/bash
#Запуск скрипта sudo ./hw3_2.sh
useradd -m $1
passwd $1
touch /home/$1/info
uname -a > /home/$1/info
echo "=================================" >> /home/$1/info
df -h >> /home/$1/info
echo "=================================" >> /home/$1/info
lscpu >> /home/$1/info
echo "=================================" >> /home/$1/info
lsblk >> /home/$1/info
