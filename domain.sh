#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
ns_domain_cloudflare1() {
apt install jq curl -y
clear

read -rp "Sub Domain (Contoh: xlord): " -e sub
DOMAIN=myvpnstoree.com
echo $sub > /root/cfku
SUB_DOMAIN=${sub}.myvpnstoree.com
CF_ID=xlordstoreofc@gmail.com
CF_KEY=a37077a98a128ab30116a6669b1ede5814cc3
echo ".myvpnstoree.com" > /root/domain
echo $SUB_DOMAIN > /root/domain

set -euo pipefail
IP=$(wget -qO- ipinfo.io/ip);
echo "Record DNS ${SUB_DOMAIN}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}')
echo "Host : $SUB_DOMAIN"
echo $SUB_DOMAIN > /root/domain
cp /root/domain /etc/xray/domain

#wget -O /usr/bin/dhn "https://raw.githubusercontent.com/myridwan/scvip/ipuk/CDN/A/I/U/E/O/dhn.sh"
#wget -O /usr/bin/dhn2 "https://raw.githubusercontent.com/myridwan/scvip/ipuk/CDN/A/I/U/E/O/dhn2.sh"
#wget -O /usr/bin/dhn3 "https://raw.githubusercontent.com/myridwan/scvip/ipuk/CDN/A/I/U/E/O/dhn3.sh"
#wget -O /usr/bin/nza "https://raw.githubusercontent.com/myridwan/scvip/ipuk/CDN/A/I/U/E/O/nza.sh"
#wget -O /usr/bin/wcc "https://raw.githubusercontent.com/myridwan/scvip/ipuk/CDN/A/I/U/E/O/cs_wc.sh"

#chmod +x /usr/bin/dhn
#chmod +x /usr/bin/dhn2
#chmod +x /usr/bin/dhn3
#chmod +x /usr/bin/nza
#chmod +x /usr/bin/wcc

function notif_addhost() {
    green "Notif AddHost Tele"
    sleep 2
    CHATID="$CHATID"
KEY="$KEY"
TIME="$TIME"
URL="$URL"
TEXT="
<code>━━━━━━━━━━━━━━</code>
<b>   ⚠️ADDHOST NOTIF⚠️</b>
<b>     Add Domain New</b>
<code>━━━━━━━━━━━━━━</code>
<b>IP VPS  :</b> <code>$MYIP </code>
<b>DOMAIN :</b> <code>$sub</code>
<code>━━━━━━━━━━━━━━</code>
<code>NEW ADD DOMAIN</code>
<code>BY BOT : @xlordeuyy</code>
"
curl -s --max-time $TIME -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
}
pasang_domain
pasang_ssl
notif_addhost

echo -e "Done Record Domain= ${SUB_DOMAIN} For VPS"
sleep 1
}
ns_domain_cloudflare1
