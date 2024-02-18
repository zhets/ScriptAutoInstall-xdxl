#!/bin/bash
exitsc="\033[0m"
y="\033[1;93m"
j="\033[0;33m"
function lane() {
echo -e "${y}────────────────────────────────────────────${exitsc}"
}
url_izin="https://raw.githubusercontent.com/zhets/izinsc/main/ip"
ipsaya=$(curl -sS ipv4.icanhazip.com)
data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
date_list=$(date +"%Y-%m-%d" -d "$data_server")
checking_sc() {
useexp=$(wget -qO- $url_izin | grep $ipsaya | awk '{print $3}')
if [[ $date_list < $useexp ]]; then
echo -ne
else
lane
echo -e "\033[42m          404 NOT FOUND AUTOSCRIPT          ${exitsc}"
lane
echo -e ""
echo -e "            \033[0;35mPERMISSION DENIED !${exitsc}"
echo -e "   ${j}Your VPS${exitsc} $ipsaya ${j}Has been Banned${exitsc}"
echo -e "     ${j}Buy access permissions for scripts${exitsc}"
echo -e "             ${j}Contact Admin :${exitsc}"
echo -e "      \033[0;36mWhatsapp${exitsc} wa.me/6285935195701"
echo -e "      \033[0;36mTelegram${exitsc} t.me/xdxl_store"
lane
exit
fi
}
checking_sc

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
