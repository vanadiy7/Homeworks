!/usr/bin/env bash
 mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON simple_lamp.* TO 'username'@'%';" \
 && mysql -uroot -proot simple_lamp < /tmp/simple_lamp.sql