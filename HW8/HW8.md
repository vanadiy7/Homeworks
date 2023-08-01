## 1.Вывести в консоль список всех пользователей системы.
---
	vanadiy@vanadiy:~$ compgen -u
	root
	daemon
	bin
	sys
	sync
	games
	man
	lp
	mail
	news
	uucp
	proxy
	www-data
	backup
	list
	irc
	gnats
	nobody
	systemd-network
	systemd-resolve
	messagebus
	systemd-timesync
	syslog
	_apt
	tss
	uuidd
	systemd-oom
	tcpdump
	avahi-autoipd
	usbmux
	dnsmasq
	kernoops
	avahi
	cups-pk-helper
	rtkit
	whoopsie
	sssd
	speech-dispatcher
	fwupd-refresh
	nm-openvpn
	saned
	colord
	geoclue
	pulse
	gnome-initial-setup
	hplip
	gdm
	vanadiy
	landscape
	new_admin_user
	sshd
	test_user
	vvv
	test_hw
	telnetd
---

## 2.Найти и вывести в консоль домашние каталоги для текущего пользователя и root.
---
	vanadiy@vanadiy:~$ cat ./user_home.sh 
		#!/usr/bin/bash

	cat /etc/passwd | grep -w $1 | awk -F":" '{print $6}'
---

## 3.Создать Bash скрипт get-date.sh, выводящий текущую дату.
---
	vanadiy@vanadiy:~$ cat ./get-date.sh 
	#!/usr/bin/bash

    	date
---

## 4.Запустить скрипт через ./get-date.sh и bash get-date.sh. Какой вариант не работает? Сделать так, чтобы оба варианта работали.
---
	vanadiy@vanadiy:~$ ./get-date.sh
	bash: ./get-date.sh: Permission denied
	vanadiy@vanadiy:~$ bash ./get-date.sh
	Tue Aug  1 10:33:03 AM +03 2023
	vanadiy@vanadiy:~$ chmod +x ./get-date.sh 
	vanadiy@vanadiy:~$ ./get-date.sh
	Tue Aug  1 10:33:19 AM +03 2023
	vanadiy@vanadiy:~$ 
---

## 5.Создать пользователей alice и bob с домашними директориями и установить /bin/bash в качестве командной оболочки по умолчанию.
---
	vanadiy@vanadiy:~$ sudo useradd -m -s /bin/bash Alice
	[sudo] password for vanadiy: 
	vanadiy@vanadiy:~$ sudo useradd -m -s /bin/bash Bob
	vanadiy@vanadiy:~$ cat /etc/passwd | grep -E 'Alice|Bob'
	Alice:x:1005:1005::/home/Alice:/bin/bash
	Bob:x:1006:1006::/home/Bob:/bin/bash
	vanadiy@vanadiy:~$ sudo passwd Alice
	New password: 
	BAD PASSWORD: The password is a palindrome
	Retype new password: 
	passwd: password updated successfully
	vanadiy@vanadiy:~$ sudo passwd Bob
	New password: 
	BAD PASSWORD: The password is a palindrome
	Retype new password: 
	passwd: password updated successfully
---

## 6.Запустить интерактивную сессию от пользователя alice. Создать файл secret.txt с каким-нибудь секретом в домашней директории при помощи текстового редактора nano.
---
	vanadiy@vanadiy:~$ su - Alice
	Password: 
	Alice@vanadiy:~$ 
	Alice@vanadiy:~$ pwd
	/home/Alice
	Alice@vanadiy:~$ nano ./secret.txt
---

## 7.Вывести права доступа к файлу secret.txt
---
	Alice@vanadiy:~$ ls -lah ./secret.txt 
	-rw-rw-r-- 1 Alice Alice 13 жні  1 10:52 ./secret.txt
---

## 8.выйти из сессии от alice и открыть сессию от bob. Вывести содержимое файла /home/alice/secret.txt созданного ранее не прибегая к команде sudo. В случае, если это не работает, объяснить.
---
	Alice@vanadiy:~$ exit
	logout
	vanadiy@vanadiy:~$ su - Bob
	Password: 
	Bob@vanadiy:~$ cat /home/Alice/secret.txt
	cat: /home/Alice/secret.txt: Permission denied
	Предполагаю, что доступа к файлу нет ввиду отсутствия у директории ./ для остальных пользователей флага Х, который дает доступ к inode. Если флаг снят, то невозможно прочитать файл  из-за невозможности получить доступ к атрибутам.
---

## 9.Создать файл secret.txt с каким-нибудь секретом в каталоге /tmp при помощи текстового редактора nano.
---
	Bob@vanadiy:~$ nano /tmp/secret.txt
	Bob@vanadiy:~$ ls -l /tmp/secret.txt
	-rw-rw-r-- 1 Bob Bob 14 жні  1 11:30 /tmp/secret.txt
---

## 10.Вывести права доступа к файлу secret.txt. Поменять права таким образом, чтобы этот файл могли читать только владелец и члены группы, привязанной к файлу.
---
	Bob@vanadiy:~$ chmod 660 /tmp/secret.txt 
	Bob@vanadiy:~$ ls -l /tmp/secret.txt
	-rw-rw---- 1 Bob Bob 14 жні  1 11:30 /tmp/secret.txt
---

## 11.Выйти из сессии от bob и открыть сессию от alice. Вывести содержимое файла /tmp/secret.txt созданного ранее не прибегая к команде sudo.
---
	Bob@vanadiy:~$ exit
	logout
	vanadiy@vanadiy:~$ su - Alice
	Password: 
	Alice@vanadiy:~$ cat /tmp/secret.txt
	secert Bob!!!
---

## 12.Добавить пользователя alice в группу, привязанную к файлу /tmp/secret.txt.
---
	vanadiy@vanadiy:~$ sudo usermod -a -G Bob Alice
	vanadiy@vanadiy:~$ cat /etc/group | grep Bob
	Bob:x:1006:Alice
---

## 13.Вывести содержимое файла /tmp/secret.txt.
---
	Alice@vanadiy:~$ cat /tmp/secret.txt
	secert Bob!!!
---

## 14.Скопировать домашнюю директорию пользователя alice в директорию /tmp/alice с помощью rsync.
---
	vanadiy@vanadiy:~$ sudo rsync --archive --verbose --progress /home/Alice/ /tmp/Alice/
	sending incremental file list
	./
	.bash_history
	            189 100%    0.00kB/s    0:00:00 (xfr#1, to-chk=7/9)
	.bash_logout
	            220 100%  214.84kB/s    0:00:00 (xfr#2, to-chk=6/9)
	.bashrc
	          3,771 100%    3.60MB/s    0:00:00 (xfr#3, to-chk=5/9)
	.profile
	            807 100%  788.09kB/s    0:00:00 (xfr#4, to-chk=4/9)
	secret.txt
	             13 100%    0.60kB/s    0:00:00 (xfr#5, to-chk=3/9)
	.local/
	.local/share/
	.local/share/nano/
	
	sent 5,505 bytes  received 130 bytes  3,756.67 bytes/sec
	total size is 5,000  speedup is 0.89
	vanadiy@vanadiy:~$ ls -la /tmp/Alice/
	ls: cannot open directory '/tmp/Alice/': Permission denied
	vanadiy@vanadiy:~$ sudo ls -la /tmp/Alice/
	total 32
	drwxr-x---  3 Alice Alice 4096 Aug  1 10:55 .
	drwxrwxrwt 21 root  root  4096 Aug  1 12:39 ..
	-rw-------  1 Alice Alice  189 Aug  1 11:28 .bash_history
	-rw-r--r--  1 Alice Alice  220 Jan  6  2022 .bash_logout
	-rw-r--r--  1 Alice Alice 3771 Jan  6  2022 .bashrc
	drwxrwxr-x  3 Alice Alice 4096 Aug  1 10:52 .local
	-rw-r--r--  1 Alice Alice  807 Jan  6  2022 .profile
	-rw-rw-r--  1 Alice Alice   13 Aug  1 10:52 secret.txt
---

## 15.Скопировать домашнюю директорию пользователя alice в директорию /tmp/alice на другую VM по SSH с помощью rsync. Как альтернатива, можно скопировать любую папку с хоста на VM по SSH
---
	vanadiy@vanadiy:~$ rsync --archive --verbose --progress /home/Alice/ vanadiy@192.168.100.4:/tmp/Alice/
	sending incremental file list
	./
	.bash_history
	            189 100%    0.00kB/s    0:00:00 (xfr#1, to-chk=7/9)
	.bash_logout
	            220 100%  214.84kB/s    0:00:00 (xfr#2, to-chk=6/9)
	.bashrc
	          3,771 100%    3.60MB/s    0:00:00 (xfr#3, to-chk=5/9)
	.profile
	            807 100%  788.09kB/s    0:00:00 (xfr#4, to-chk=4/9)
	secret.txt
	             13 100%   12.70kB/s    0:00:00 (xfr#5, to-chk=3/9)
	.local/
	.local/share/
	.local/share/nano/
	
	sent 5,505 bytes  received 130 bytes  288.97 bytes/sec
	total size is 5,000  speedup is 0.89
	vanadiy@vanadiy:~$ ssh vanadiy@192.168.100.4
	vanadiy@ubn:~$ ls -la /tmp/Alice
	total 32
	drwxr-x---  3 vanadiy vanadiy 4096 Aug  1 07:55 .
	drwxrwxrwt 13 root    root    4096 Aug  1 09:46 ..
	-rw-------  1 vanadiy vanadiy  189 Aug  1 08:28 .bash_history
	-rw-r--r--  1 vanadiy vanadiy  220 Jan  6  2022 .bash_logout
	-rw-r--r--  1 vanadiy vanadiy 3771 Jan  6  2022 .bashrc
	drwxrwxr-x  3 vanadiy vanadiy 4096 Aug  1 07:52 .local
	-rw-r--r--  1 vanadiy vanadiy  807 Jan  6  2022 .profile
	-rw-rw-r--  1 vanadiy vanadiy   13 Aug  1 07:52 secret.txt
---

## 16. Удалить пользователей alice и bob вместе с домашними директориями.
---
	vanadiy@vanadiy:~$ sudo userdel -r Bob
	userdel: group Bob not removed because it has other members.
	userdel: Bob mail spool (/var/mail/Bob) not found
	vanadiy@vanadiy:~$ sudo userdel -r Alice
	userdel: Alice mail spool (/var/mail/Alice) not found
	vanadiy@vanadiy:~$ cat /etc/passwd | grep -w 'Alice|Bob'
	vanadiy@vanadiy:~$
---

## 17.С помощью утилиты htop определить какой процесс потребляет больше всего ресурсов в системе.
---
	vanadiy@vanadiy:~/vladimir-bobko$ htop -s PERCENT_MEM
	vanadiy@vanadiy:~/vladimir-bobko$ htop -s PERCENT_CPU
	Если вывести по памяти, то больще всего нагружает virtual box
	Если по процессору, то Firefox
---

## 18.Вывести логи сервиса Firewall с помощью journalctl не прибегая к фильтрации с помощью grep.
---
	vanadiy@vanadiy:~$ journalctl -u ufw.service
	Apr 24 17:45:11 vanadiy systemd[1]: Starting Uncomplicated firewall...
	Apr 24 17:45:11 vanadiy systemd[1]: Finished Uncomplicated firewall.
	-- Boot 41ce7b3c0fb44dd79f5d01071bde88aa --
	Jun 22 19:17:07 vanadiy systemd[1]: Starting Uncomplicated firewall...
	Jun 22 19:17:08 vanadiy systemd[1]: Finished Uncomplicated firewall.
	-- Boot f82578639a78400388ab33c627bee025 --
	Jun 26 18:33:01 vanadiy systemd[1]: Starting Uncomplicated firewall...
	Jun 26 18:33:01 vanadiy systemd[1]: Finished Uncomplicated firewall.
	-- Boot 2910b9ec11e5491cab552a5275cce836 --
	Jun 27 20:05:00 vanadiy systemd[1]: Starting Uncomplicated firewall...
	Jun 27 20:05:00 vanadiy systemd[1]: Finished Uncomplicated firewall.
	-- Boot 0caf00db950f47428ff11a9baccb2493 --
	Jun 28 19:04:53 vanadiy systemd[1]: Starting Uncomplicated firewall...
	Jun 28 19:04:54 vanadiy systemd[1]: Finished Uncomplicated firewall.
	-- Boot 55a531f4b1dc41cc8ff9b79534291e25 --
	Jun 29 09:57:57 vanadiy systemd[1]: Starting Uncomplicated firewall...
	Jun 29 09:57:57 vanadiy systemd[1]: Finished Uncomplicated firewall.
	-- Boot 8cd1f092d88c4dacbf41c1cd2c286b60 --
	Jul 03 11:44:34 vanadiy systemd[1]: Starting Uncomplicated firewall...
	Jul 03 11:44:34 vanadiy systemd[1]: Finished Uncomplicated firewall.
	-- Boot d6d5f019983549259e083f2aa292661d --
	Jul 03 11:56:36 vanadiy systemd[1]: Starting Uncomplicated firewall...
	Jul 03 11:56:36 vanadiy systemd[1]: Finished Uncomplicated firewall.
	-- Boot fd3a374eadea4128af7a7090f75e7b27 --
	Jul 05 13:53:57 vanadiy systemd[1]: Starting Uncomplicated firewall...
	Jul 05 13:53:57 vanadiy systemd[1]: Finished Uncomplicated firewall.
	-- Boot e59cd12d9aa5426da698ed3b59cc0253 --
	Jul 05 20:20:41 vanadiy systemd[1]: Starting Uncomplicated firewall...
	Jul 05 20:20:41 vanadiy systemd[1]: Finished Uncomplicated firewall.
	-- Boot 14db49653fe847809b4fa693d8e591ab --
	Jul 06 10:27:39 vanadiy systemd[1]: Starting Uncomplicated firewall...
	Jul 06 10:27:39 vanadiy systemd[1]: Finished Uncomplicated firewall.
	-- Boot a9e12fc514d84120af4eca46495f6b04 --
	Jul 19 20:15:24 vanadiy systemd[1]: Starting Uncomplicated firewall...
---
