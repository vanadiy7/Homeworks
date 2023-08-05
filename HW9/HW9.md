## 1-4.Добавить новый диск к виртуальной машине и проверить, что система видит его.
---
  До добавления диска в VM:
  vanadiy@ubn:~$ sudo fdisk -l
  Disk /dev/sda: 30 GiB, 32212254720 bytes, 62914560 sectors
  Disk model: VBOX HARDDISK   
  Units: sectors of 1 * 512 = 512 bytes
  Sector size (logical/physical): 512 bytes / 512 bytes
  I/O size (minimum/optimal): 512 bytes / 512 bytes
  Disklabel type: gpt
  Disk identifier: 011B0993-F3D6-4298-BCA0-688CA5E4710F
    Device       Start      End  Sectors Size Type
  /dev/sda1     2048     4095     2048   1M BIOS boot
  /dev/sda2     4096  4198399  4194304   2G Linux filesystem
  /dev/sda3  4198400 62912511 58714112  28G Linux filesystem
  Disk /dev/mapper/ubuntu--vg-ubuntu--lv: 14 GiB, 15028191232 bytes, 29351936 sectors
  Units: sectors of 1 * 512 = 512 bytes
  Sector size (logical/physical): 512 bytes / 512 bytes
  I/O size (minimum/optimal): 512 bytes / 512 bytes
  После добавления диска:
  vanadiy@ubn:~$ sudo fdisk -l
  Disk /dev/sda: 30 GiB, 32212254720 bytes, 62914560 sectors
  Disk model: VBOX HARDDISK   
  Units: sectors of 1 * 512 = 512 bytes
  Sector size (logical/physical): 512 bytes / 512 bytes
  I/O size (minimum/optimal): 512 bytes / 512 bytes
  Disklabel type: gpt
  Disk identifier: 011B0993-F3D6-4298-BCA0-688CA5E4710F
  Device       Start      End  Sectors Size Type
  /dev/sda1     2048     4095     2048   1M BIOS boot
  /dev/sda2     4096  4198399  4194304   2G Linux filesystem
  /dev/sda3  4198400 62912511 58714112  28G Linux filesystem
  Disk /dev/sdb: 5 GiB, 5368709120 bytes, 10485760 sectors
  Disk model: VBOX HARDDISK   
  Units: sectors of 1 * 512 = 512 bytes
  Sector size (logical/physical): 512 bytes / 512 bytes
  I/O size (minimum/optimal): 512 bytes / 512 bytes
  Disk /dev/mapper/ubuntu--vg-ubuntu--lv: 14 GiB, 15028191232 bytes, 29351936 sectors
  Units: sectors of 1 * 512 = 512 bytes
  Sector size (logical/physical): 512 bytes / 512 bytes
  I/O size (minimum/optimal): 512 bytes / 512 bytes
  vanadiy@ubn:~$ lsblk
  NAME                      MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
  loop0                       7:0    0  63.4M  1 loop /snap/core20/1974
  loop1                       7:1    0  63.3M  1 loop /snap/core20/1822
  loop2                       7:2    0 111.9M  1 loop /snap/lxd/24322
  loop3                       7:3    0  49.8M  1 loop /snap/snapd/18357
  loop4                       7:4    0  53.3M  1 loop /snap/snapd/19457
  sda                         8:0    0    30G  0 disk 
  ├─sda1                      8:1    0     1M  0 part 
  ├─sda2                      8:2    0     2G  0 part /boot
  └─sda3                      8:3    0    28G  0 part 
    └─ubuntu--vg-ubuntu--lv 253:0    0    14G  0 lvm  /
  sdb                         8:16   0     5G  0 disk 
  sr0                        11:0    1  1024M  0 rom  
  Посмотрим список физических томов
  vanadiy@ubn:~$ sudo pvs
    PV         VG        Fmt  Attr PSize   PFree 
    /dev/sda3  ubuntu-vg lvm2 a--  <28.00g 14.00g
  Корневой каталог для VM рассположен на Physical Volumes /dev/sda3 в Volums Groups ubuntu-vg. Попробуем расширить его.
  vanadiy@ubn:~$ sudo pvcreate /dev/sdb
    Physical volume "/dev/sdb" successfully created.
  vanadiy@ubn:~$ sudo pvs
    PV         VG        Fmt  Attr PSize   PFree 
    /dev/sda3  ubuntu-vg lvm2 a--  <28.00g 14.00g
    /dev/sdb             lvm2 ---    5.00g  5.00g
  vanadiy@ubn:~$ sudo vgs
    VG        #PV #LV #SN Attr   VSize   VFree 
    ubuntu-vg   1   1   0 wz--n- <28.00g 14.00g
  vanadiy@ubn:~$ sudo vgextend ubuntu-vg /dev/sdb
    Volume group "ubuntu-vg" successfully extended
  vanadiy@ubn:~$ sudo vgs
    VG        #PV #LV #SN Attr   VSize  VFree  
    ubuntu-vg   2   1   0 wz--n- 32.99g <19.00g
  vanadiy@ubn:~$ sudo lvs
    LV        VG        Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
    ubuntu-lv ubuntu-vg -wi-ao---- <14.00g                                                    
  vanadiy@ubn:~$ sudo lvextend -L+5G /dev/ubuntu-vg/ubuntu-lv
    Size of logical volume ubuntu-vg/ubuntu-lv changed from <14.00 GiB (3583 extents) to <19.00 GiB (4863 extents).
    Logical volume ubuntu-vg/ubuntu-lv successfully resized.
  vanadiy@ubn:~$ sudo lvs
    LV        VG        Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
    ubuntu-lv ubuntu-vg -wi-ao---- <19.00g 
  vanadiy@ubn:~$ lsblk
  NAME                      MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
  loop0                       7:0    0  63.4M  1 loop /snap/core20/1974
  loop1                       7:1    0  63.3M  1 loop /snap/core20/1822
  loop2                       7:2    0 111.9M  1 loop /snap/lxd/24322
  loop3                       7:3    0  49.8M  1 loop /snap/snapd/18357
  loop4                       7:4    0  53.3M  1 loop /snap/snapd/19457
  sda                         8:0    0    30G  0 disk 
  ├─sda1                      8:1    0     1M  0 part 
  ├─sda2                      8:2    0     2G  0 part /boot
  └─sda3                      8:3    0    28G  0 part 
    └─ubuntu--vg-ubuntu--lv 253:0    0    19G  0 lvm  /
  sdb                         8:16   0     5G  0 disk 
  sr0                        11:0    1  1024M  0 rom  
  vanadiy@ubn:~$ sudo df -h
  Filesystem                         Size  Used Avail Use% Mounted on
  tmpfs                              197M  1.1M  196M   1% /run
  /dev/mapper/ubuntu--vg-ubuntu--lv   14G  5.0G  8.1G  39% /
  tmpfs                              983M     0  983M   0% /dev/shm
  tmpfs                              5.0M     0  5.0M   0% /run/lock
  /dev/sda2                          2.0G  130M  1.7G   8% /boot
  tmpfs                              197M  4.0K  197M   1% /run/user/1000
  vanadiy@ubn:~$ sudo resize2fs /dev/ubuntu-vg/ubuntu-lv
  resize2fs 1.46.5 (30-Dec-2021)
  Filesystem at /dev/ubuntu-vg/ubuntu-lv is mounted on /; on-line resizing required
  old_desc_blocks = 2, new_desc_blocks = 3
  The filesystem on /dev/ubuntu-vg/ubuntu-lv is now 4979712 (4k) blocks long.
  
  vanadiy@ubn:~$ sudo df -Th
  Filesystem                        Type   Size  Used Avail Use% Mounted on
  tmpfs                             tmpfs  197M  1.1M  196M   1% /run
  /dev/mapper/ubuntu--vg-ubuntu--lv ext4    19G  5.0G   13G  28% /
  tmpfs                             tmpfs  983M     0  983M   0% /dev/shm
  tmpfs                             tmpfs  5.0M     0  5.0M   0% /run/lock
  /dev/sda2                         ext4   2.0G  130M  1.7G   8% /boot
  tmpfs                             tmpfs  197M  4.0K  197M   1% /run/user/1000
---

## 5.Вывести в консоль текущую рабочую директорию.
---
  vanadiy@vanadiy:~$ pwd
  /home/vanadiy
---

## 6.Вывести в консоль все файлы из домашней директории.
---
  vanadiy@vanadiy:~$ ls -la ./
  total 356
  drwxr-x--- 24 vanadiy vanadiy  4096 Aug  4 11:53  .
  drwxr-xr-x  8 root    root     4096 Aug  2 18:43  ..
  drwxrwxr-x  2 vanadiy vanadiy  4096 Jul  3 17:32  1111
  -rw-------  1 vanadiy vanadiy   239 Jul  5 14:52  2023-07-05-11-52-28.017-VBoxSVC-2465.log
  drwxrwxr-x  2 vanadiy vanadiy  4096 Jul  3 17:33  2222
  -rw-------  1 vanadiy vanadiy 30627 Aug  4 13:34  .bash_history
  -rw-r--r--  1 vanadiy vanadiy   220 Apr 24 17:13  .bash_logout
  -rw-r--r--  1 vanadiy vanadiy  3771 Apr 24 17:13  .bashrc
  drwx------ 14 vanadiy vanadiy  4096 Jul 27 18:10  .cache
  drwx------ 21 vanadiy vanadiy  4096 Jul 27 18:10  .config
  -rw-rw-r--  1 vanadiy vanadiy 12907 Jul 26 16:41  curlyaru
  drwxr-xr-x  3 vanadiy vanadiy  4096 Jun 22 19:21  Desktop
  drwxr-xr-x  2 vanadiy vanadiy  4096 Apr 24 17:45  Documents
  drwxrwxr-x  3 vanadiy vanadiy  4096 Jul 27 22:23  .dotnet
  drwxr-xr-x  2 vanadiy vanadiy  4096 Jul 23 20:21  Downloads
  -rw-rw-r--  1 vanadiy vanadiy     0 Aug  4 15:50  error.log
  -rw-rw-r--  1 vanadiy vanadiy  2628 Jul 20 09:20  file.log
  drwxrwxr-x  3 vanadiy vanadiy  4096 Jul 27 11:15  git
  -rw-rw-r--  1 vanadiy vanadiy    60 Jul 27 10:38  .gitconfig
  -rw-------  1 vanadiy vanadiy  2602 Jul 27 11:35  git_rsa
  -rw-r--r--  1 vanadiy vanadiy   569 Jul 27 11:35  git_rsa.pub
  drwx------  2 vanadiy vanadiy  4096 Jul 27 16:32  .gnupg
  -rwxrwxr-x  1 vanadiy vanadiy   525 Jul 23 20:14  hw3_1.sh
  -rwxrwxr-x  1 vanadiy vanadiy   373 Jul 20 08:37  hw3_2.sh
  -rw-rw-r--  1 vanadiy vanadiy   315 Jul 20 08:45  hw3_3
  -rw-rw-r--  1 vanadiy vanadiy 28324 Jul 23 20:18  HW4
  -rwxrwxr-x  1 vanadiy vanadiy    87 Jul 23 17:42  HW_4.sh
  -rw-rw-r--  1 vanadiy vanadiy  3713 Jul 25 17:28  HW5
  -rw-rw-r--  1 vanadiy vanadiy  2957 Jul 26 16:52  HW6
  -rw-rw-r--  1 vanadiy vanadiy 16197 Jul 27 22:10  HW7.md
  -rw-rw-r--  1 vanadiy vanadiy     0 Jul 20 08:39  immortalfile
  -rw-rw-r--  1 vanadiy vanadiy 52801 Aug  4 15:50  infocron.log
  -rw-rw-r--  1 vanadiy vanadiy  2048 Jul 23 18:02  info_hw4.log
  -rw-------  1 vanadiy vanadiy    20 Aug  4 11:53  .lesshst
  -rw-rw-r--  1 vanadiy vanadiy  6655 Jul 31 22:22  LISENSE
  drwx------  3 vanadiy vanadiy  4096 Apr 24 17:45  .local
  drwxr-xr-x  2 vanadiy vanadiy  4096 Apr 24 17:45  Music
  -rw-r--r--  1 vanadiy vanadiy   310 Jul  5 21:45  .pam_environment
  drwxr-xr-x  2 vanadiy vanadiy  4096 Apr 24 17:45  Pictures
  drwx------  3 vanadiy vanadiy  4096 Jul 27 18:10  .pki
  -rw-r--r--  1 vanadiy vanadiy   807 Apr 24 17:13  .profile
  drwxr-xr-x  2 vanadiy vanadiy  4096 Apr 24 17:45  Public
  -rwxrwxr-x  1 vanadiy vanadiy    72 Jul 31 19:55  scrp.sh
  -rw-rw-r--  1 vanadiy vanadiy    66 Jun 29 15:49  .selected_editor
  drwx------  6 vanadiy vanadiy  4096 Jul 27 18:09  snap
  drwx------  2 vanadiy vanadiy  4096 Jul 27 12:00  .ssh
  -rw-r--r--  1 vanadiy vanadiy     0 Jun 27 21:00  .sudo_as_admin_successful
  -rw-rw-r--  1 vanadiy vanadiy 19593 Jul 25 16:04  telnetdump
  drwxr-xr-x  2 vanadiy vanadiy  4096 Apr 24 17:45  Templates
  -rwxrwxr-x  1 vanadiy vanadiy    72 Aug  1 10:19  user_home.sh
  drwxr-xr-x  2 vanadiy vanadiy  4096 Apr 24 17:45  Videos
  drwxrwxr-x  4 vanadiy vanadiy  4096 Jul  5 20:26 'VirtualBox VMs'
  drwxrwxr-x 11 vanadiy vanadiy  4096 Aug  4 11:53  vladimir-bobko
  drwxrwxr-x  4 vanadiy vanadiy  4096 Jul 27 18:10  .vscode
---

## 7.Построить маршрут до google.com при помощи утилиты traceroute.
---
  vanadiy@vanadiy:~$ traceroute google.com
  traceroute to google.com (142.250.186.206), 30 hops max, 60 byte packets
   1  192.168.100.1 (192.168.100.1)  5.713 ms  12.972 ms  12.925 ms
   2  mm-1-128-127-178.mgts.dynamic.pppoe.byfly.by (178.127.128.1)  14.701 ms  14.682 ms  14.653 ms
   3  mm-61-80-84-93.dynamic.pppoe.mgts.by (93.84.80.61)  16.028 ms  15.965 ms  14.450 ms
   4  core2.net.belpak.by (93.85.80.57)  19.767 ms  19.753 ms  19.712 ms
   5  ie1.net.belpak.by (93.85.80.38)  14.222 ms ie2.net.belpak.by (93.85.80.54)  17.804 ms  17.787 ms
   6  asbr10.net.belpak.by (93.85.80.229)  15.344 ms asbr10.net.belpak.by (93.85.80.233)  4.500 ms  6.687 ms
   7  194.158.197.209 (194.158.197.209)  27.190 ms 194.158.197.210 (194.158.197.210)  33.400 ms 194.158.197.209 (194.158.197.209)  27.553 ms
   8  * * *
   9  108.170.252.65 (108.170.252.65)  35.474 ms 108.170.252.1 (108.170.252.1)  34.141 ms  35.445 ms
  10  108.170.250.201 (108.170.250.201)  14.283 ms 108.170.251.144 (108.170.251.144)  58.654 ms 108.170.251.208 (108.170.251.208)  40.344 ms
  11  192.178.73.111 (192.178.73.111)  37.438 ms * 142.250.37.193 (142.250.37.193)  11.318 ms
  12  142.251.245.150 (142.251.245.150)  29.667 ms 142.251.245.206 (142.251.245.206)  59.713 ms  51.680 ms
  13  142.250.226.64 (142.250.226.64)  29.453 ms 142.250.37.209 (142.250.37.209)  31.100 ms 142.250.226.64 (142.250.226.64)  28.858 ms
  14  142.250.239.81 (142.250.239.81)  34.064 ms 209.85.252.117 (209.85.252.117)  37.194 ms  36.476 ms
  15  waw07s05-in-f14.1e100.net (142.250.186.206)  36.483 ms  15.870 ms 142.250.239.81 (142.250.239.81)  36.401 ms
---

## 8.Установить Sonatype Nexus OSS по следующей инструкции, а именно:
   - установку произвести в директорию /opt/nexus.
   - запустить приложение от отдельного пользователя nexus.
   - реализовать systemd оболочку для запуска приложения как сервис.
---
  vanadiy@ubn:~$ sudo apt install openjdk-8-jre-headless
  vanadiy@ubn:~$ cd /opt
  vanadiy@ubn:/opt$ sudo wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz
  vanadiy@ubn:/opt$ sudo  tar -zxvf latest-unix.tar.gz
  vanadiy@ubn:/opt$ ls -l
  total 208500
  -rw-r--r--  1 root root 213495610 Jul 25 11:59 latest-unix.tar.gz
  drwxr-xr-x 10 root root      4096 Aug  4 13:16 nexus-3.58.1-02
  drwxr-xr-x  3 root root      4096 Aug  4 13:16 sonatype-work
  vanadiy@ubn:/opt$ sudo mv /opt/nexus-3.58.1-02 /opt/nexus
  vanadiy@ubn:/opt$ ls -l
  total 208500
  -rw-r--r--  1 root root 213495610 Jul 25 11:59 latest-unix.tar.gz
  drwxr-xr-x 10 root root      4096 Aug  4 13:16 nexus
  drwxr-xr-x  3 root root      4096 Aug  4 13:16 sonatype-work
  vanadiy@ubn:/opt$ sudo adduser nexus
  vanadiy@ubn:/opt$ sudo visudo
  vanadiy@ubn:/opt$ sudo chown -R nexus:nexus /opt/nexus
  vanadiy@ubn:/opt$ sudo chown -R nexus:nexus /opt/sonatype-work
  vanadiy@ubn:/opt$ sudo nano /opt/nexus/bin/nexus.rc
  vanadiy@ubn:/opt$ sudo nano /opt/nexus/bin/nexus.vmoptions
  vanadiy@ubn:/opt$ sudo nano /etc/systemd/system/nexus.service
  vanadiy@ubn:/opt$ sudo systemctl start nexus
  vanadiy@ubn:/opt$ sudo systemctl start nexus
  vanadiy@ubn:/opt$ sudo systemctl status nexus
  ● nexus.service - nexus service
       Loaded: loaded (/etc/systemd/system/nexus.service; disabled; vendor preset: enabled)
       Active: active (running) since Fri 2023-08-04 13:34:29 UTC; 34s ago
      Process: 3261 ExecStart=/opt/nexus/bin/nexus start (code=exited, status=0/SUCCESS)
     Main PID: 3463 (java)
        Tasks: 37 (limit: 2220)
       Memory: 453.1M
          CPU: 33.393s
       CGroup: /system.slice/nexus.service
               └─3463 /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java -server -Dinstall4j.jvmDir=/usr/lib/jvm/java-8-o>
  
  Aug 04 13:34:29 ubn systemd[1]: Starting nexus service...
  Aug 04 13:34:29 ubn nexus[3261]: Starting nexus
  Aug 04 13:34:29 ubn systemd[1]: Started nexus service.
  lines 1-14/14 (END)
  vanadiy@ubn:/opt$ sudo systemctl enable nexus
  Created symlink /etc/systemd/system/multi-user.target.wants/nexus.service → /etc/systemd/system/nexus.service.
---
