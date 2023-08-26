#!/bin/bash
function menu(){
    clear
    print_install "Memasang Menu Packet"
    wget https://xlordofc.com/menu/admin.zip
    unzip admin.zip
    chmod +x admin/*
    mv menu/* /usr/local/sbin
    rm -rf menu
    rm -rf menu.zip
}
clear
echo -e "\033[1;36m=======================================\033[0m"
echo -e " \e[1;97;101m          Proses Ganti Tema          \e[0m"
echo -e "\033[1;36m=======================================\033[0m"
echo -e ""
echo -e "  \033[1;91m Donee Ganti Tema...\033[1;37m"
fun_bar 'res1'
echo -e "\033[1;36m=======================================\033[0m"
echo -e ""
read -n 1 -s -r -p "Press [ Enter ] to back on menu"
menu
