#!/bin/bash

function install-bot(){
apt update -y && apt upgrade -y
apt install python3 python3-pip git speedtest-cli -y
cd /usr/bin
clear
wget https://raw.githubusercontent.com/nilacanti/pap/main/menu/ftvpn.zip &> /dev/null
unzip ftvpn.zip &> /dev/null
pip3 install -r ftvpn/requirements.txt
cd /usr/bin/ftvpn/bot
chmod +x *
mv -f * /usr/bin
rm -rf /usr/bin/ftvpn/bot
rm -rf /usr/bin/ftvpn.zip
cd
clear
echo -e "\033[1;36m┌━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┐\033[0m"
echo -e "   \e[1;97;101m      Masukan Id Tele & TokenBot       \e[0m"
echo -e "\033[1;36m└━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┘\033[0m"
echo -e "${grenbo}Tutorial Creat Bot and ID Telegram${NC}"
echo -e "${grenbo}[*] Creat Bot and Token Bot : @BotFather${NC}"
echo -e "${grenbo}[*] Info Id Telegram : @MissRose_bot , perintah /info${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
read -rp "[*] Input your Bot Token : " -e bottoken 
read -rp "[*] Input Your Id Telegram : " -e admin
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
clear
rm -rf /usr/bin/ddsdswl.session
rm -rf /usr/bin/ftvpn/var.txt
rm -rf /usr/bin/ftvpn/database.db
if [[ ${c} != "0" ]]; then
  echo "${d}" >/etc/bot/${bottoken}
fi
DATADB=$(cat /etc/bot/.bot.db | grep "^#bot#" | grep -w "${bottoken}" | awk '{print $2}')
if [[ "${DATADB}" != '' ]]; then
  sed -i "/\b${user}\b/d" /etc/bot/.bot.db
fi
echo "#bot# ${bottoken} ${admin}" >>/etc/bot/.bot.db

cat >/usr/bin/ftvpn/var.txt <<EOF
BOT_TOKEN="$bottoken"
ADMIN="$admin"
DOMAIN="$domain"
EOF

echo "$bottoken" > /etc/per/token
echo "$admin" > /etc/per/id
echo "$bottoken" > /usr/bin/token
echo "$admin" > /usr/bin/idchat
echo "$bottoken" > /etc/perlogin/token
echo "$admin" > /etc/perlogin/id
clear

echo "SHELL=/bin/sh" >/etc/cron.d/cekbot
echo "PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin" >>/etc/cron.d/cekbot
echo "*/1 * * * * root /usr/bin/cekbot" >>/etc/cron.d/cekbot

cat > /usr/bin/cekbot << END
nginx=$( systemctl status ftvpn | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $nginx == "running" ]]; then
    echo -ne
else
    systemctl restart ftvpn
    systemctl start ftvpn
fi

ftvpn=$( systemctl status ftvpn | grep "TERM" | wc -l )
if [[ $ftvpn == "0" ]]; then
echo -ne
else
    systemctl restart ftvpn
    systemctl start ftvpn
fi
END

cat > /etc/systemd/system/ftvpn.service << END
[Unit]
Description=Simple ftvpn - @ftvpn
After=syslog.target network-online.target

[Service]
WorkingDirectory=/usr/bin
ExecStart=/usr/bin/python3 -m ftvpn
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl stop ftvpn
systemctl enable ftvpn
systemctl start ftvpn
systemctl restart ftvpn

echo "Done"
echo " Installations complete, type /menu on your bot"
read -n 1 -s -r -p "Press any key to back on menu"
menu
}
cd
if [ -e /usr/bin/ftvpn ]; then
echo -ne
else
install-bot
fi
done
