#!/bin/bash
REPO="https://raw.githubusercontent.com/zhets/zhets/ScriptAutoInstall-xdxl/main/"
mkdir -p /usr/local/xdxl/
wget -q -O /usr/local/xdxl/badvpn-udpgpw "${REPO}badvpn/badvpn-udpgpw"
chmod +x /usr/local/xdxl/badvpn-udpgpw
wget -q -O /etc/systemd/system/badvpn-1.service "${REPO}badvpn/badvpn-1.service"
wget -q -O /etc/systemd/system/badvpn-2.service "${REPO}badvpn/badvpn-2.service"
wget -q -O /etc/systemd/system/badvpn-3.service "${REPO}badvpn/badvpn-3.service"
wget -q -O /etc/systemd/system/badvpn-4.service "${REPO}badvpn/badvpn-4.service"
wget -q -O /etc/systemd/system/badvpn-5.service "${REPO}badvpn/badvpn-5.service"

systemctl disable badvpn-1
systemctl stop badvpn-1
systemctl enable badvpn-1
systemctl start badvpn-1

systemctl disable badvpn-2
systemctl stop badvpn-2
systemctl enable badvpn-2
systemctl start badvpn-2

systemctl disable badvpn-3
systemctl stop badvpn-3
systemctl enable badvpn-3
systemctl start badvpn-3

systemctl disable badvpn-4
systemctl stop badvpn-4
systemctl enable badvpn-4
systemctl start badvpn-4

systemctl disable badvpn-5
systemctl stop badvpn-5
systemctl enable badvpn-5
systemctl start badvpn-5
