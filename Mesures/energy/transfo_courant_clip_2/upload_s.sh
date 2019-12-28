#!/bin/bash
# Petit script pour télécharger facilement tout le binz via le port série
#zf191228.2313

# S'il y a des erreurs lors d'un téléchargement, il faut simplement augmenter un peu le délai !
# Il est préférable de télécharger en premier les *gros* fichiers .lua !

# ATTENTION: cela efface tout le NodeMCU !

luatool_tty="/dev/cu.wchusbserial1410"

echo ""
read -p "ATTENTION, cela va effacer tout le NodeMCU !"
read -p "Etes-vous vraiment certain ?"

chmod +x luatool.py

./luatool.py --port $luatool_tty -w
./luatool.py --port $luatool_tty -l
read -p "Est-ce bien vide ?"

./luatool.py --port $luatool_tty --bar -f z_index.html
./luatool.py --port $luatool_tty --bar -f wifi_init.lua
./luatool.py --port $luatool_tty --bar -f wifi_info.lua
./luatool.py --port $luatool_tty --bar -f wifi_clear.html
./luatool.py --port $luatool_tty --bar -f web_srv2.lua
./luatool.py --port $luatool_tty --bar -f web_ide2.lua
./luatool.py --port $luatool_tty --bar -f telnet_srv2.lua
./luatool.py --port $luatool_tty --bar -f set_time.lua
./luatool.py --port $luatool_tty --bar -f secrets_wifi.lua
./luatool.py --port $luatool_tty --bar -f secrets_project.lua
./luatool.py --port $luatool_tty --bar -f head.lua
./luatool.py --port $luatool_tty --bar -f eus_params.lua
./luatool.py --port $luatool_tty --bar -f disp_temp.html
./luatool.py --port $luatool_tty --bar -f dir2.lua
./luatool.py --port $luatool_tty --bar -f cat.lua
./luatool.py --port $luatool_tty --bar -f boot2.lua
./luatool.py --port $luatool_tty --bar -f boot.lua
./luatool.py --port $luatool_tty --bar -f 0_send_data.lua
#./luatool.py --port $luatool_tty --bar -f 0_htu21d.lua
./luatool.py --port $luatool_tty --bar -f 0_cron.lua

./luatool.py --port $luatool_tty -l
read -p "Pas eu d'erreur, on part à fond avec le init.lua ?"

./luatool.py --port $luatool_tty --bar -f initz.lua -t init.lua
./luatool.py --port $luatool_tty -l
echo -e "\nC'est tout bon ;-)"
