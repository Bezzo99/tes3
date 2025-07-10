#!/bin/bash
# =========================================
# Quick Setup | Script Setup Manager
# Edition : Stable Edition V3.1
# Auther  : Geo Project
# (C) Copyright 2024
# =========================================
clear
domain=$(cat /etc/xray/domain)
IP=$( curl -s ifconfig.me )
 apt show haproxy
 apt install haproxy -y
 haproxy -v
 apt purge haproxy -y
 add-apt-repository ppa:vbernat/haproxy-2.4 -y
 apt update
 apt install haproxy=2.4.\* -y
rm -rf /etc/haproxy/haproxy.cfg
 wget -q -O /etc/squid/squid.conf "https://jaka1m.github.io/project/ssh/squid.conf" >/dev/null 2>&1
    wget -O /etc/haproxy/haproxy.cfg "https://jaka1m.github.io/project/xray/haproxy.cfg" >/dev/null 2>&1
    wget -O /etc/nginx/conf.d/xray.conf "https://jaka1m.github.io/project/xray/xray.conf" >/dev/null 2>&1
    sed -i "s/xxx/${domain}/g" /etc/haproxy/haproxy.cfg
    sed -i "s/xxx/${domain}/g" /etc/nginx/conf.d/xray.conf
    sed -i "s/xxx/${IP}/g" /etc/squid/squid.conf
    systemctl enable haproxy
    systemctl start haproxy
    systemctl restart haproxy
cat /etc/xray/xray.crt /etc/xray/xray.key | tee /etc/haproxy/hap.pem
    echo ""
cat >/lib/systemd/system/haproxy.service <<EOF
[Unit]
Description=GeoProject Load Balancer
Documentation=GEOVPN
After=network-online.target rsyslog.service

[Service]
ExecStart=/usr/sbin/ftvpn -Ws -f /etc/haproxy/haproxy.cfg -p 18173 
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF
echo ""
reboot
