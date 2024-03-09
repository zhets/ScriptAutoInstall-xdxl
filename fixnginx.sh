#!/bin/bash
rm -f /etc/nginx/nginx.conf
rm -f /etc/nginx/conf.d/xdproject.conf
rm -f /etc/nginx/conf.d/nginx.conf >/dev/null 2>&1
wget https://github.com/zhets/ScriptAutoInstall-xdxl/raw/main/xdproject.conf -O /etc/nginx/conf.d/xdproject.conf
wget https://github.com/zhets/ScriptAutoInstall-xdxl/raw/main/nginx.conf -O /etc/nginx/nginx.conf
echo -e "\033[0;35m Successfully Fix Nginx & Change Port Nginx 81 > 445 \033[0m"
sleep 3;menu
