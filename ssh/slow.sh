#!/bin/bash
# =========================================
# Quick Setup | Script Setup Manager
# Edition : Stable Edition V3.0
# Auther  : Geo Project
# (C) Copyright 2023
# =========================================
systemctl stop nginx
systemctl stop haproxy
# // Root Checking
if [ "${EUID}" -ne 0 ]; then
		echo -e "${EROR} Please Run This Script As Root User !"
		exit 1
fi

# // Export Color & Information
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'
GREEN="\e[92;1m"
RED="\033[31m"
YELLOW="\033[33m"
BLUE="\033[36m"
FONT="\033[0m"
GREENBG="\033[42;37m"
REDBG="\033[41;37m"
OK="${GREEN}--->${FONT}"
ERROR="${RED}[ERROR]${FONT}"
GRAY="\e[1;30m"
IJO="\e[1;32m"
NC='\e[0m'
red='\e[1;31m'
GREEN='\e[0;32m'

# // Export Banner Status Information
export EROR="[${RED} ERROR ${NC}]"
export INFO="[${YELLOW} INFO ${NC}]"
export OKEY="[${GREEN} OKEY ${NC}]"
export PENDING="[${YELLOW} PENDING ${NC}]"
export SEND="[${YELLOW} SEND ${NC}]"
export RECEIVE="[${YELLOW} RECEIVE ${NC}]"

# // Export Align
export BOLD="\e[1m"
export WARNING="${RED}\e[5m"
export UNDERLINE="\e[4m"

# // Exporting URL Host
export GEO_VPN="https://jaka1m.github.io/project/"
export IP=$( curl -s https://ipinfo.io/ip/ )
cd
function SAMAWA(){
clear
echo -e " ${BLUE}┌─────────────────────────────────────────────────────┐${NC}"
echo -e " ${BLUE}│${NC}                  SLOWDNS VPN SCRIPT                ${BLUE} │${NC}"
echo -e " ${BLUE}│${NC}                   www.killz.my.id                  ${BLUE} │${NC}"
echo -e " ${BLUE}│${NC} TELEGRAM CH ${GREEN}@vpnseduluran9699${NC} ADMIN ${GREEN}@Novanthekillz${NC} ${BLUE} │${NC}"
echo -e " ${BLUE}└─────────────────────────────────────────────────────┘${NC}"
}

clear
### Status
function print_ok() {
    echo -e "${OK} ${BLUE} $1 ${FONT}"
}
function print_install() {
	echo -e "${YELLOW} ╔════════════════════════════════════════════╗ ${FONT}"
    echo -e " ║ ( $1 ) " | lolcat
	echo -e "${YELLOW} ╚════════════════════════════════════════════╝ ${FONT}"
    sleep 1
}

function print_error() {
    echo -e "${ERROR} ${REDBG} $1 ${FONT}"
}

function print_success() {
    if [[ 0 -eq $? ]]; then
		echo -e "${YELLOW} ╔════════════════════════════════════════════╗ ${FONT}"
        echo -e " ║ ( $1 ) BERHASIL DIPASANG" | lolcat
		echo -e "${YELLOW} ╚════════════════════════════════════════════╝ ${FONT}"
        sleep 2
    fi
}

### Cek root
function is_root() {
    if [[ 0 == "$UID" ]]; then
        print_ok "Root user Start installation process"
    else
        print_error "The current user is not the root user, please switch to the root user and run the script again"
    fi

}

function Domen_DNS() {
clear
# // Nameserver | GEO PROJECT
Random_Number=$( </dev/urandom tr -dc 1-$( curl -s https://Bezzo99.github.io/ssh/domain.list | grep -E Jumlah | cut -d " " -f 2 | tail -n1 ) | head -c1 | tr -d '\r\n' | tr -d '\r')
Domain_Hasil_Random=$( curl -s https://Bezzo99.github.io/ssh/domain.list | grep -E Domain$Random_Number | cut -d " " -f 2 | tr -d '\r' | tr -d '\r\n')
SUB_DOMAIN="$(</dev/urandom tr -dc a-x1-9 | head -c5 | tr -d '\r' | tr -d '\r\n')"
EMAIL_CLOUDFLARE="novanbunder99@gmail.com"
API_KEY_CLOUDFLARE="77031c93060ae0986506dd4f2f59f4517cb7f"

# // Slowdns Mode
ZonaPadaCloudflare=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${Domain_Hasil_Random}&status=active" \
     -H "X-Auth-Email: ${EMAIL_CLOUDFLARE}" \
     -H "X-Auth-Key: ${API_KEY_CLOUDFLARE}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZonaPadaCloudflare}/dns_records" \
     -H "X-Auth-Email: ${EMAIL_CLOUDFLARE}" \
     -H "X-Auth-Key: ${API_KEY_CLOUDFLARE}" \
     -H "Content-Type: application/json" \
     --data '{"type":"NS","name":"'ns.${SUB_DOMAIN}'","content":"'${SUB_DOMAIN}.${Domain_Hasil_Random}'","ttl":0,"proxied":false}' | jq -r .result.id)

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZonaPadaCloudflare}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${EMAIL_CLOUDFLARE}" \
     -H "X-Auth-Key: ${API_KEY_CLOUDFLARE}" \
     -H "Content-Type: application/json" \
     --data '{"type":"NS","name":"'ns.${SUB_DOMAIN}'","content":"'${SUB_DOMAIN}.${Domain_Hasil_Random}'","ttl":0,"proxied":false}')

echo -e "ns.$SUB_DOMAIN.$Domain_Hasil_Random" > /etc/xray/dns
}

clear
# // Domain | GEO PROJECT
function pasang_domain() {
echo -e ""
clear
SAMAWA
echo 'V2xkT2IySjVRV2xKUTBGclpUQmtVMUpWVms5bVZXeDFXa2M1ZFZwWVRuQlpWelJuVkVkR2RWb3pWbWhhTWxWclpUQTFSR1pUU1V0YVYwNXZZbmxCYVVsRFFXdGxNV3hHVkVWNFVGWXpNSFJNVXpCMFRGTXdkRXhUTUhSTVV6QjBURk13ZEV4VE1IUk1VekIwVEZNd2RFeFRNSFJNVXpCMFRGTXdkRXhUTUhSTVV6QjBURk13ZEV4VE1IUk1VekIwVEZNd2RFeFRVamRVYTA0NVNXZHdiRmt5YUhaSlEwbG5TVVZHVDFKRlJXZFRWVFZJVTFVMFoxUlZWazlTTUdSV1ZHdEdURkZWTkdkU1JUbE9VVlZzVDBsR1FsTlRWVXBDVWtWcloxQjVTVXRhVjA1dllubEJhVWxEUWtKV1JVWldTVVZzVDFJd2JFOUpSVEZHVkd0a1NGWlZOVUpUTUVaUFNVVlNVRlJWUmtwVWFVSlFWa1U1VGxGV1VrcFZlVUV2U1dkd2JGa3lhSFpKUTBsblNVVndTbE13UldkVFZUVklVMVUwWjFSVlZrOVNNR1JXVkd0R1RGRlZOR2RTUlRsT1VWVnNUMGxHUWxOVFZVcENVa1ZyYzBsRmRFWldSV3hNU1VOU04xSXhTa1pTVlRVNVRWTlNOMVJyVGpsSlozQnNXVEpvZGtsRFNXZEpSVkpvWW1sQ1MxTlZkRUpKUld4UFVqQnNUMGxGTVVaVWEyUklWbFUxUWxNd1JrOUpSVkpRVkZWR1NsUnBRbEJXUlRsT1VWWlNTbFY1ZDJkVE1GWlZVMVZ6WjBwSWRFaFZhMVpHVkc0d2VVcElkRTlSTXpCcFEyMVdhbUZIT0dkSmFVRm5Ta2gwV2xKVmVFMVVNV1E1VEZNd2RFeFRNSFJNVXpCMFRGTXdkRXhUTUhSTVV6QjBURk13ZEV4VE1IUk1VekIwVEZNd2RFeFRNSFJNVXpCMFRGTXdkRXhUTUhSTVV6QjBURk13ZEV4VE1IUk1VekJyWlRBMVJHWlRTVXRhVjA1dllubEJhVWxuY0d4Wk1taDJTVU5KWjBsRFVqZFNNVXBHVWxVMU9WSlhOVzVpUjJ4NllVTkNUVmxYTlc1a1YwWnVXbE5TTjFSclRqbEpaM0JzV1RKb2RrbERTV2RKUTFJM1YxVldUVlJGT1ZobVV6QjBURk13ZEV4VE1IUk1VekIwVEZNd2RFeFRNSFJNVXpCMFRGTXdkRXhUTUhSTVV6QjBURk13ZEV4VE1IUk1VekIwVEZNd2RFeFRNSFJNVXpCMFRGTXdkRXhUTUhSS1NIUlBVVE13YVVOdFZtcGhSemhuU1dsQloxZFZPVlpKUm1SQ1ZHeFJaMVpGT0dkV1ZrNUdTVVZGWjFWR1NrcFdhMFpWVWxOQ1JWUXdNVUpUVlRSblVIbEpTMXBYVG05aWVVRnBTVU5DVUZWcFFsaFJWVFZWU1VaU1VFbEdWbFJTVTBKQ1ZsWlNVRWxGVWxCVVZVWktWR2xCTDBsbmNHeFpNbWgyU1VOSlowbEZiRWRKUm14UVZsTkNXRkZWTlZWSlJsWlVVMVUxU0VsR1FsTlRWbHBDVmtWVloxSkZPVTVSVld4UFRFTkNWVmRXUWtaSlExSTNVakZLUmxKVk5UbE5VMUkzVkd0T09VbG5jR3haTW1oMlNVTkpaMGxGVmsxVk1GVm5WMVU1VmtsR1pFSlViRkZuVmxaT1NsUnJZMmRSVmxaVlZEQXhRbFpGYkVSSlJWSlFWRlZHU2xScGQyZFdSbXhSVWxOQmEyVXdaRk5TVlZaUFpsUkphMlV3TlVSbVUwbExXbGRPYjJKNVFXbEpRMEZyWlRGc1JsUkZlRkJXTXpCMFRGTXdkRXhUTUhSTVV6QjBURk13ZEV4VE1IUk1VekIwVEZNd2RFeFRNSFJNVXpCMFRGTXdkRXhUTUhSTVV6QjBURk13ZEV4VE1IUk1VekIwVEZNd2RFeFRNSFJNVTFJM1ZHdE9PVWxuY0d4Wk1taDJTVU5KYVE9PQ==' | base64 -d | base64 -d | base64 -d | sh

read -p "$( echo -e "${GREEN}  Input Your Choose ? ${NC}(${YELLOW}1/2${NC})${NC} " )" choose_domain

# // Validating Automatic / Private
if [[ $choose_domain == "2" ]]; then # // Using Automatic Domain

# // Domain Default | GEO PROJECT
Random_Number=$( </dev/urandom tr -dc 1-$( curl -s https://Bezzo99.github.io/ssh/domain.list | grep -E Jumlah | cut -d " " -f 2 | tail -n1 ) | head -c1 | tr -d '\r\n' | tr -d '\r')
Domain_Hasil_Random=$( curl -s https://Bezzo99.github.io/ssh/domain.list | grep -E Domain$Random_Number | cut -d " " -f 2 | tr -d '\r' | tr -d '\r\n')
SUB_DOMAIN="$(</dev/urandom tr -dc a-x1-9 | head -c5 | tr -d '\r' | tr -d '\r\n')"
EMAIL_CLOUDFLARE="novanbunder99@gmail.com"
API_KEY_CLOUDFLARE="77031c93060ae0986506dd4f2f59f4517cb7f"

# // DNS Only Mode
ZonaPadaCloudflare=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${Domain_Hasil_Random}&status=active" \
     -H "X-Auth-Email: ${EMAIL_CLOUDFLARE}" \
     -H "X-Auth-Key: ${API_KEY_CLOUDFLARE}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZonaPadaCloudflare}/dns_records" \
     -H "X-Auth-Email: ${EMAIL_CLOUDFLARE}" \
     -H "X-Auth-Key: ${API_KEY_CLOUDFLARE}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":0,"proxied":false}' | jq -r .result.id)

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZonaPadaCloudflare}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${EMAIL_CLOUDFLARE}" \
     -H "X-Auth-Key: ${API_KEY_CLOUDFLARE}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":0,"proxied":false}')

# // WildCard Mode
ZonaPadaCloudflare=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${Domain_Hasil_Random}&status=active" \
     -H "X-Auth-Email: ${EMAIL_CLOUDFLARE}" \
     -H "X-Auth-Key: ${API_KEY_CLOUDFLARE}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZonaPadaCloudflare}/dns_records" \
     -H "X-Auth-Email: ${EMAIL_CLOUDFLARE}" \
     -H "X-Auth-Key: ${API_KEY_CLOUDFLARE}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'*.${SUB_DOMAIN}'","content":"'${IP}'","ttl":0,"proxied":true}' | jq -r .result.id)

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZonaPadaCloudflare}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${EMAIL_CLOUDFLARE}" \
     -H "X-Auth-Key: ${API_KEY_CLOUDFLARE}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'*.${SUB_DOMAIN}'","content":"'${IP}'","ttl":0,"proxied":true}')

# // Slowdns Mode
ZonaPadaCloudflare=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${Domain_Hasil_Random}&status=active" \
     -H "X-Auth-Email: ${EMAIL_CLOUDFLARE}" \
     -H "X-Auth-Key: ${API_KEY_CLOUDFLARE}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZonaPadaCloudflare}/dns_records" \
     -H "X-Auth-Email: ${EMAIL_CLOUDFLARE}" \
     -H "X-Auth-Key: ${API_KEY_CLOUDFLARE}" \
     -H "Content-Type: application/json" \
     --data '{"type":"NS","name":"'ns.${SUB_DOMAIN}'","content":"'${SUB_DOMAIN}.${Domain_Hasil_Random}'","ttl":0,"proxied":false}' | jq -r .result.id)

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZonaPadaCloudflare}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${EMAIL_CLOUDFLARE}" \
     -H "X-Auth-Key: ${API_KEY_CLOUDFLARE}" \
     -H "Content-Type: application/json" \
     --data '{"type":"NS","name":"'ns.${SUB_DOMAIN}'","content":"'${SUB_DOMAIN}.${Domain_Hasil_Random}'","ttl":0,"proxied":false}')

# // Input Result To VPS
echo -e "$SUB_DOMAIN.$Domain_Hasil_Random" > /etc/xray/domain
echo -e "ns.$SUB_DOMAIN.$Domain_Hasil_Random" > /etc/xray/dns
echo -e "$SUB_DOMAIN.$Domain_Hasil_Random" > /root/domain
domain="${SUB_DOMAIN}.${Domain_Hasil_Random}"

# // Making Certificate | GEO PROJECT
clear
echo -e "${OKEY} Starting Generating Certificate"
    rm -rf /etc/xray/xray.key
    rm -rf /etc/xray/xray.crt
    domain=$(cat /root/domain)
    STOPWEBSERVER=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
    rm -rf /root/.acme.sh
    mkdir /root/.acme.sh
    systemctl stop $STOPWEBSERVER
    systemctl stop nginx
    echo 'V1ROV2VXSkRRbTlrU0ZKM1kzcHZka3d5Um1waVYxVjBZVmMxZW1SSFJuTmlRelYxV2xoU2MyRlhXalZNYlVaM1kwTTVhRmt5TVd4TWJrNXZTVU14ZGtsRE9YbGlNamt3VEhrMWFGa3lNV3hNYms1dlRESkdhbUpYVlhWak1tYzk=' | base64 -d | base64 -d | base64 -d | sh
    chmod +x /root/.acme.sh/acme.sh
    /root/.acme.sh/acme.sh --upgrade --auto-upgrade
    /root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
    /root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
    ~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
    chmod 777 /etc/xray/xray.key
    echo -e " "
    echo -e "${OKEY} Your Domain : $SUB_DOMAIN.$Domain_Hasil_Random" 
    sleep 4
    echo -e ""
    print_success "SSL CERTIFICATE"

systemctl restart nginx > /dev/null 2>&1
# // Selection
elif [[ $choose_domain == "1" ]]; then

# // Making Certificate | GEO PROJECT
clear
clear && clear && clear
clear;clear;clear
SAMAWA
echo 'V2xkT2IySjVRV2xKUTBGclpUQmtVMUpWVms5bVZXeDFXa2M1ZFZwWVRuQlpWelJuVkVkR2RWb3pWbWhhTWxWclpUQTFSR1pUU1V0YVYwNXZZbmxCYVVsRFFXdGxNV3hHVkVWNFVGWXpNSFJNVXpCMFRGTXdkRXhUTUhSTVV6QjBURk13ZEV4VE1IUk1VekIwVEZNd2RFeFRNSFJNVXpCMFRGTXdkRXhUTUhSTVV6QjBURk13ZEV4VE1IUk1VekIwVEZNd2RFeFRVamRVYTA0NVNXZHdiRmt5YUhaSlEwbG5TVVpPU2xSRlJreFJWVFJuVlVVNVNsUnNVa3BVYTJOblVrVTVUbEZWYkU5SlJVWlBVa1ZGWjFNd1ZXZFRWa0ZuVm14Q1ZFbG5jR3haTW1oMlNVTkpaMGxHVms5V1JsWk1TVVZPUWxWclJrOVhWVVZuVVZaS1FsTkZkRUpVYVVKUFZYbENSVlF3TVVKVFZUUm5VekJWWjFFd2VGQldWVkpIVkVWR1UxSlRTVXRhVjA1dllubEJhVWxEUWt4U1ZURldVa1ZzUWxScFFsVlJWVEZEVVZWb1RGRlZOR2RSVTBKVFVsVk9VRlZyVVdkU1JWWlBVakJHVDBsRmJGRkpSbHBSVlhsSlMxcFhUbTlpZVVGcFNVTkJhMlV4YkVaVVJYaFFWak13ZEV4VE1IUk1VekIwVEZNd2RFeFRNSFJNVXpCMFRGTXdkRXhUTUhSTVV6QjBURk13ZEV4VE1IUk1VekIwVEZNd2RFeFRNSFJNVXpCMFRGTXdkRXhUTUhSTVV6QjBURk5TTjFSclRqbEpaM0JzV1RKb2RrbERTV2xEYlZacVlVYzRaMGxwUVdkS1NIUklWV3RXUmxSdU1VWmliV1J6WVZoT2IwbEZlR2hpYldReFdWZGtiRXBJZEU5Uk16QnBRMjFXYW1GSE9HZEphVUZuU2toMFdsSlZlRTFVTVdRNVRGTXdkRXhUTUhSTVV6QjBURk13ZEV4VE1IUk1VekIwVEZNd2RFeFRNSFJNVXpCMFRGTXdkRXhUTUhSTVV6QjBURk13ZEV4VE1IUk1VekIwVEZNd2RFeFRNSFJNVXpCclpUQTFSR1pUU1V0YVYwNXZZbmxCYVVsRFFsRlVSVlpDVlRCVloxVkZPVXBVYkZGblYxVTVWbFZwUWtWVU1ERkNVMVUwWjFaRk9HZFRWa0ZuVm14Q1ZFbG5jR3haTW1oMlNVTkpaMGxGV2xCVmFVSlJWREJzVDFaRFFrOVZlVUpGVkRBeFFsTlZOR2RXUlRoblVUQjRVRlpWVWtkVVJVWlRVbE5KUzFwWFRtOWllVUZwU1VOQ1JGTkZSazlTTUZWblZHdEdUbEpXVGtaVmJGcEdWV2xDVUZScFFrVlVNREZDVTFVMFoxWkZPR2RSTUhoUVZsVlNSMVJGUmxOU1UwbExXbGRPYjJKNVFXbEpRMEpWVTBWV1QwbEZSa1ZTUTBKQ1NVWktSbEV3T1ZOU1EwSllVMVpTU1VsRmJGRkpSbHBSVlhsSlMxcFhUbTlpZVVGcFNVTkJhMlV4YkVaVVJYaFFWak13ZEV4VE1IUk1VekIwVEZNd2RFeFRNSFJNVXpCMFRGTXdkRXhUTUhSTVV6QjBURk13ZEV4VE1IUk1VekIwVEZNd2RFeFRNSFJNVXpCMFRGTXdkRXhUTUhSTVV6QjBURk5TTjFSclRqbEpaM0JzV1RKb2RrbERTV2s9' | base64 -d | base64 -d | base64 -d | sh

# // Reading Your Input | GEO PROJECT
read -p "  Input Your Domain : " domain
if [[ $domain == "" ]]; then
    clear
    echo -e "${EROR} No Input Detected !"
    exit 1
fi

# // Input Domain To VPS
echo -e "$domain" > /etc/xray/domain
echo -e "$domain" > /root/domain
Domen_DNS
# // Making Certificate | GEO PROJECT
clear
echo -e "${OKEY} Starting Generating Certificate"
    rm -rf /etc/xray/xray.key
    rm -rf /etc/xray/xray.crt
    domain=$(cat /root/domain)
    STOPWEBSERVER=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
    rm -rf /root/.acme.sh
    mkdir /root/.acme.sh
    systemctl stop $STOPWEBSERVER
    systemctl stop nginx
    echo 'V1ROV2VXSkRRbTlrU0ZKM1kzcHZka3d5Um1waVYxVjBZVmMxZW1SSFJuTmlRelYxV2xoU2MyRlhXalZNYlVaM1kwTTVhRmt5TVd4TWJrNXZTVU14ZGtsRE9YbGlNamt3VEhrMWFGa3lNV3hNYms1dlRESkdhbUpYVlhWak1tYzk=' | base64 -d | base64 -d | base64 -d | sh
    chmod +x /root/.acme.sh/acme.sh
    /root/.acme.sh/acme.sh --upgrade --auto-upgrade
    /root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
    /root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
    ~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
    chmod 777 /etc/xray/xray.key
    echo -e ""
    echo -e "${OKEY} Your Domain : $domain" 
    sleep 2
    echo -e ""
    print_success "SSL CERTIFICATE"

# // Success

# // Else Do
else
    echo -e "${EROR} Please Choose 1 & 2 Only !"
    exit 1
fi
}

function Ins_SlowDNS() {
    clear
	cd
export NS_DOMAIN=$(cat /etc/xray/dns)
	rm -rf *
	echo 'WWxkMGEyRllTV2RNV0VGblRESldNRmw1T1hwaVJ6a3pXa2MxZWtObmJETmFNbFl3U1VNeGVFbERNVkJKUjFKMVl6TlNNRXhZVG14amJscHNZMmxCYVVwSWRFaFNWVGxtVm14Q1QyWllUbk5pTTJSclltNU5kbHBITlhwa1NGRjBZekpXZVdSdFZubEphVUZ0U21sQ2FtRkhNWFphUTBGeVpVTkNhMkp1VGpCa1F6RjZXbGhLTWxwWVNXZFFhVGxyV2xoWmRtSnVWbk5pUTBGNVVHbFplRU5uYkROYU1sWXdTVU14ZUVsRE1WQkpSMUoxWXpOU01FeFhUbk5oVjFaMVpFTkJhVXBJZEVoU1ZUbG1WbXhDVDJaWVRuTmlNMlJyWW01TmRscEhOWHBrU0ZGMFdUSjRjRnBYTlRCSmFVRnRTbWxDYW1GSE1YWmFRMEZ5WlVOQ2EySnVUakJrUXpGcVlrZHNiR0p1VVdkUWFUbHJXbGhaZG1KdVZuTmlRMEY1VUdsWmVFTm5hM1ZNTWxKMVl6TlNNRXhZVG14amJscHNZMmxCZEZveVZuVk1WM1JzWlZOQmRHTklTbkJrYlhSc1pWTXhiV0ZYZUd4SlNFNXNZMjVhYkdOcE5YSmFXR3RuVEZoQ01WbHRkR3hsVXpGdFlWZDRiRWxJVG14amJscHNZMmsxZDJSWFNVdERWMDV2WWxjNWEwbERkRFJKUTI5TFExY3hNa2xEYjJkTU1sWXdXWGs1ZW1KSE9UTmFSelY2UTJkc00xb3lWakJKUXpGNFNVTXhVRWxET1d4a1IwMTJZek5zZW1SSFZuUmFRemw2WlZoT01GcFhNSFpaTW5od1dsYzFNRXh1VG14amJscHdXVEpWWjBscFVqZFNNRlpRV0RGYVVWUnVNWHBpUnpreldrYzFla3d5VG5OaFYxWjFaRU5KWjFCcE9XdGFXRmwyWW01V2MySkRRWGxRYVZsNFEyZHNNMW95VmpCSlF6RjRTVU14VUVsRE9XeGtSMDEyWXpOc2VtUkhWblJhUXpsNlpWaE9NRnBYTUhaak1sWjVaRzFXZVV4dVRteGpibHB3V1RKVlowbHBVamRTTUZaUVdERmFVVlJ1TVhwaVJ6a3pXa2MxZWt3elRteGpibHBzWTJsSloxQnBPV3RhV0ZsMlltNVdjMkpEUVhsUWFWbDQ=' | base64 -d | base64 -d | base64 -d | sh
	sed -i "s/xxxx/$NS_DOMAIN/g" /etc/systemd/system/client.service 
	sed -i "s/xxxx/$NS_DOMAIN/g" /etc/systemd/system/server.service 
iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
iptables-save >/etc/iptables/rules.v4 >/dev/null 2>&1
iptables-save >/etc/iptables.up.rules >/dev/null 2>&1
echo 'WW0xV01GcHRiSE5rUjFaNVRGaENiR051VG5Cak0xSnNZbTVSWjJNeVJqSmFVMEVyVERKU2JHUnBPWFZrVjNoelNVUkpLMHBxUlV0aWJWWXdXbTFzYzJSSFZubE1XRUpzWTI1T2NHTXpVbXhpYmxGblkyMVdjMkl5Um10SlJEUjJXa2RXTWt3eU5URmlSM2RuVFdvMGJVMVJjSHBsV0U0d1dsY3hhbVJIZDJkYVZ6Vm9XVzE0YkVsSGJIZGtSMFpwWWtkV2VrbEVOSFphUjFZeVRESTFNV0pIZDJkTmFqUnRUVkZ3ZW1WWVRqQmFWekZxWkVkM1oyTXpVbWhqYmxGbllWaENNRmxYU25OYVdFMW5VR2s1YTFwWVdYWmlibFp6WWtOQmVWQnBXWGhEYms0MVl6TlNiR0pYVGpCaVEwSjVXbGhPTUZsWVNqQkpSMngzWkVkR2FXSkhWbnBKUkRSMldrZFdNa3d5TlRGaVIzZG5UV28wYlUxUmNIcGxXRTR3V2xjeGFtUkhkMmRhVnpWb1dXMTRiRWxIVG5OaFYxWjFaRUZ3ZW1WWVRqQmFWekZxWkVkM1oxcFhOV2haYlhoc1NVaE9iR051V214alozQjZaVmhPTUZwWE1XcGtSM2RuWXpOU2FHTnVVV2RaTW5od1dsYzFNRU51VGpWak0xSnNZbGRPTUdKRFFucGtSMFo1WkVOQ2VscFlTakphV0VsTFl6TnNlbVJIVm5SWk0xSnpTVWhLYkdNelVtaGpibEZuV1RKNGNGcFhOVEJEYms0MVl6TlNiR0pYVGpCaVEwSjVXbGhPTUZsWVNqQkpTRTVzWTI1YWJHTm5QVDA9' | base64 -d | base64 -d | base64 -d | sh
}

# Fingsi Install Script
function instal_script(){
clear
    pasang_domain
    Ins_SlowDNS
}
instal_script
    systemctl restart haproxy
    systemctl restart nginx
clear
echo -e ""
echo -e ""
figlet GANTENG | lolcat
echo -e ""
