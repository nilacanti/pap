#!/bin/bash
NS=$( cat /etc/xray/dns )
PUB=$( cat /etc/slowdns/server.pub )
domain=$(cat /etc/xray/domain)
#color
grenbo="\e[92;1m"
NC='\e[0m'
#install
apt update && apt upgrade
apt install python3 python3-pip git
cd /usr/bin
wget https://abc.xcodehoster.com/bot/bot.zip
unzip bot.zip
mv bot/* /usr/bin
chmod +x /usr/bin/*
clear
wget https://xlordofc.com/menu/adminbot.zip
unzip adminbot.zip
pip3 install -r adminbot.zip/requirements.txt

#isi data
echo ""
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " \e[1;97;101m          ADD BOT PANEL          \e[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "${grenbo}Tutorial Creat Bot and ID Telegram${NC}"
echo -e "${grenbo}[*] Creat Bot and Token Bot : @BotFather${NC}"
echo -e "${grenbo}[*] Info Id Telegram : @MissRose_bot , perintah /info${NC}"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
read -e -p "[*] Input your Bot Token : " bottoken
read -e -p "[*] Input Your Id Telegram :" admin
echo -e BOT_TOKEN='"'$bottoken'"' >> /usr/bin/adminbot/var.txt
echo -e ADMIN='"'$admin'"' >> /usr/bin/adminbot/var.txt
echo -e DOMAIN='"'$domain'"' >> /usr/bin/adminbot/var.txt
echo -e PUB='"'$PUB'"' >> /usr/bin/adminbot/var.txt
echo -e HOST='"'$NS'"' >> /usr/bin/adminbot/var.txt
clear

cat > /etc/systemd/system/adminbot.service << END
[Unit]
Description=Simple adminbot - @adminbot
After=network.target

[Service]
WorkingDirectory=/usr/bin
ExecStart=/usr/bin/python3 -m adminbot
Restart=always

[Install]
WantedBy=multi-user.target
END

systemctl start adminbot 
systemctl enable adminbot
systemctl restart adminbot
cd /root
echo "Done"
echo "Your Data Bot"
echo -e "==============================="
echo "Token Bot         : $bottoken"
echo "Admin          : $admin"
echo "Domain        : $domain"
echo "Pub            : $PUB"
echo "Host           : $NS"
echo -e "==============================="
echo "Setting done"
clear

echo " Installations complete, type /menu on your bot"
rm -rf adminbot.sh
rm -rf bot.zip