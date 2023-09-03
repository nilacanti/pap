#!/bin/bash
# //====================================================
# //	System Request:Debian 9+/Ubuntu 18.04+/20+
# //	Author:	Geo Project
# //	Dscription: Xray Menu Management
# //	email: admin@geolstore.net
# //  telegram: https://t.me/tau_samawa
# //====================================================

# // Root Checking
if [ "${EUID}" -ne 0 ]; then
		echo -e "${EROR} Please Run This Script As Root User !"
		exit 1
fi

# // Exporting Language to UTF-8
export LC_ALL='en_US.UTF-8' > /dev/null
export LANG='en_US.UTF-8' > /dev/null
export LANGUAGE='en_US.UTF-8' > /dev/null
export LC_CTYPE='en_US.utf8' > /dev/null

# // Export Color & Information
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'
OR='\033[1;93m'
Lred='\e[91m'
LLgreen='\e[92m'
Lyellow='\e[93m'
yellow="\033[1;33m"
green="\e[92;1m"
yellow="\033[1;33m"
cyan="\033[1;36m"

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
export Server_URLL="raw.githubusercontent.com/jaka1m/perizinan/main"
export Server_Port="443"
export Server_IP="underfined"
export Script_Mode="Stable"
export Auther="geovpn"
MYIP=$(curl -sS ipv4.icanhazip.com)
domain=$(cat /etc/xray/domain)

# // Exporting IP Address
export IP=$( curl -sS ipinfo.io/ip )

# // Exporting Network Interface
export NETWORK_IFACE="$(ip route show to default | awk '{print $5}')"

# // Validate Result ( 1 )
touch /etc/${Auther}/license.key
export Your_License_Key="$( cat /etc/${Auther}/license.key | awk '{print $1}' )"
export Validated_Your_License_Key_With_Server="$( curl -s https://${Server_URLL}/validated-registered-license-key.txt | grep -w $Your_License_Key | head -n1 | cut -d ' ' -f 1 )"
if [[ "$Validated_Your_License_Key_With_Server" == "$Your_License_Key" ]]; then
    validated='true'
else
    echo -e "${EROR} License Key Not Valid"
    exit 1
fi

# // Checking Script Expired
exp=$( curl -s https://${Server_URLL}/validated-registered-license-key.txt | grep -w $Your_License_Key | cut -d ' ' -f 4 )
now=`date -d "0 days" +"%Y-%m-%d"`
expired_date=$(date -d "$exp" +%s)
now_date=$(date -d "$now" +%s)
sisa_hari=$(( ($expired_date - $now_date) / 86400 ))
if [[ $sisa_hari -lt 0 ]]; then
    echo $sisa_hari > /etc/${Auther}/license-remaining-active-days.db
    echo -e "${EROR} Your License Key Expired ( $sisa_hari Days )"
    exit 1
else
    echo $sisa_hari > /etc/${Auther}/license-remaining-active-days.db
fi
clear
fun_bar() {
CMD[0]="$1"
CMD[1]="$2"
(
[[ -e $HOME/fim ]] && rm $HOME/fim
${CMD[0]} -y >/dev/null 2>&1
${CMD[1]} -y >/dev/null 2>&1
touch $HOME/fim
) >/dev/null 2>&1 &
tput civis
echo -ne "  \033[0;33mPlease Wait Loading \033[1;37m- \033[0;33m["
while true; do
for ((i = 0; i < 18; i++)); do
echo -ne "\033[0;32m#"
sleep 0.1s
done
[[ -e $HOME/fim ]] && rm $HOME/fim && break
echo -e "\033[0;33m]"
sleep 1s
tput cuu1
tput dl1
echo -ne "  \033[0;33mPlease Wait Loading \033[1;37m- \033[0;33m["
done
echo -e "\033[0;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
tput cnorm
}
res1() {
source <(curl -sL https://github.com/jaka1m/project/raw/main/up/ipserver)
}
res2() {
wget -O /etc/sysctl.conf "https://github.com/jaka1m/project/raw/main/up/sysctl.conf"
}
res3() {
wget -O /etc/haproxy/haproxy.cfg "https://github.com/jaka1m/project/raw/main/up/haproxy.cfg"
}
res4() {
wget -q -O /etc/ssh/sshd_config "https://github.com/jaka1m/project/raw/main/up/sshd"
}
res5() {
wget -O /etc/nginx/conf.d/xray.conf "https://github.com/jaka1m/project/raw/main/up/xray"
}
res6() {
wget -O /etc/nginx/nginx.conf "https://github.com/jaka1m/project/raw/main/up/nginx.conf"
}
res7() {
wget -O /usr/bin/ws.py "https://github.com/jaka1m/project/raw/main/up/ws.py"
}
res8() {
wget -O /etc/systemd/system/ws.service "https://github.com/jaka1m/project/raw/main/up/ws.service"
}
res9() {
  sysctl -p
}
res10() {
systemctl daemon-reload
  systemctl restart haproxy
  systemctl restart server
  systemctl restart client
  systemctl restart nginx
  systemctl restart ssh
  systemctl restart sshd
  systemctl enable udp
  systemctl enable ws
  systemctl start udp
  systemctl start ws
  systemctl restart udp
}
clear
echo -e "\033[0;33m ┌──────────────────────────────────────────┐\033[0m"
echo -e "\033[0;33m │\033[0m          \033[0;32mSTARTING UPDATE SERVER\033[0m          \033[0;33m|\033[0m"
echo -e "\033[0;33m └──────────────────────────────────────────┘\033[0m"
echo -e ""
echo -e "  \033[1;91m service 1\033[1;37m"
fun_bar 'res1'
echo -e "  \033[1;91m service 2\033[1;37m"
fun_bar 'res2'
echo -e "  \033[1;91m service 3\033[1;37m"
fun_bar 'res3'
echo -e "  \033[1;91m service 4\033[1;37m"
fun_bar 'res4'
echo -e "  \033[1;91m service 5\033[1;37m"
fun_bar 'res5'
echo -e "  \033[1;91m service 6\033[1;37m"
fun_bar 'res6'
echo -e "  \033[1;91m service 7\033[1;37m"
fun_bar 'res7'
echo -e "  \033[1;91m service 8\033[1;37m"
fun_bar 'res8'
echo -e "  \033[1;91m service 9\033[1;37m"
fun_bar 'res9'
echo -e "  \033[1;91m service 10\033[1;37m"
fun_bar 'res10'
echo -e ""
cat /etc/xray/xray.crt /etc/xray/xray.key | tee /etc/haproxy/hap.pem
echo ""
rm -rf /root/opo.sh
echo -e "${OKEY} Script Successfull Installed"
echo ""
read -p "$( echo -e "Press ${CYAN}[ ${NC}${GREEN}Enter${NC} ${CYAN}]${NC} For Reboot") "
reboot
