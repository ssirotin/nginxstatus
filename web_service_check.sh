#!/usr/bin/env bash
# Возвращение вывода к стандартному форматированию
NORMAL='\033[0m'

# Цветом текста (жирным) (bold) :
WHITE='\033[1;37m'

# Цвет фона
BGRED='\033[41m'
BGGREEN='\033[42m'
BGBLUE='\033[44m'

tg="/home/vagrant/bin/telegram.sh"

nginxstatus=$(systemctl status nginx | grep -Eo "running|failed|dead")
if [[ $nginxstatus == "running" ]]
  then
    echo -en "${WHITE} ${BGGREEN} web server NGINX is running $(curl -sI 192.168.0.13 | head -n 1 | cut -d $" " -f 2,3,4,5,6) ${NORMAL}\n"
    $tg "web server NGINX is running $(curl -sI 192.168.0.13 | head -n 1 | cut -d $" " -f 2,3,4,5,6)" > /dev/null
  else
    echo -en "${WHITE} ${BGRED} web server NGINX not running ${NORMAL}\n"
    $tg "web server NGINX not running $(curl -sI 192.168.0.13 | head -n 1 | cut -d $" " -f 2,3,4,5,6)" > /dev/null
    systemctl restart nginx
    sleep 1
    echo -en "${WHITE} ${BGGREEN} NGINX web server status $(systemctl status nginx | grep -Eo "running|failed|dead") after restart $(curl -sI 192.168.0.13 | head -n 1 | cut -d $" " -f 2,3,4,5,6) ${NORMAL}\n"
    $tg "NGINX web server status $(systemctl status nginx | grep -Eo "running|failed|dead") after restart $(curl -sI 192.168.0.13 | head -n 1 | cut -d $" " -f 2,3,4,5,6)" > /dev/null
fi
