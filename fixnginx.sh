#!/bin/bash
rm -f /etc/nginx/nginx.conf
rm -f /etc/nginx/conf.d/xray.conf
rm -f /etc/haproxy/haproxy.cfg >/dev/null 2>&1
wget https://github.com/zhets/ScriptAutoInstall-xdxl/raw/main/xray.conf -O /etc/nginx/conf.d/xray.conf
wget https://github.com/zhets/ScriptAutoInstall-xdxl/raw/main/nginx.conf -O /etc/nginx/nginx.conf
wget https://github.com/zhets/ScriptAutoInstall-xdxl/raw/main/haproxy.cfg -O /etc/haproxy/haproxy.cfg
wget https://github.com/zhets/ScriptAutoInstall-xdxl/raw/main/tun.conf -O /usr/bin/tun.conf
cat /etc/xray/xray.crt /etc/xray/xray.key | tee /etc/haproxy/xdxl.pem
domain=$(cat /etc/xray/domain)
sed -i "s/xxx/${domain}/g" /etc/haproxy/haproxy.cfg
sed -i "s/xxx/${domain}/g" /etc/nginx/conf.d/xray.conf
systemctl restart nginx haproxy ws
echo -e "\033[0;35m Successfully Fix Nginx, Haproxy, Ws Epro Off \033[0m"
sleep 2;menu
