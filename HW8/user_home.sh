#!/usr/bin/bash

	cat /etc/passwd | grep -w $1 | awk -F":" '{print $6}'
