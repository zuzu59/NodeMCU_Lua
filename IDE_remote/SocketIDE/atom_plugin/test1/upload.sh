#!/bin/bash
# Petit script pour télécharger facilement tout le binz
#zf191021.1555

# S'il y a des erreurs lors d'un téléchargement, il faut simplement augmenter un peu le délai !
# Il est préférable de télécharger en premier les *gros* fichiers .lua !

#ATTENTION: cela efface tout le NodeMCU !

luatool_tty="/dev/cu.wchusbserial1410"

read -p "ATTENTION, cela va effacer tout le NodeMCU !"
read -p "Etes-vous vraiment certain ?"

chmod +x luatool.py

./luatool.py --port $luatool_tty -w
./luatool.py --port $luatool_tty -l
read -p "Est-ce bien vide ?"

./luatool.py --port $luatool_tty --bar --delay 0.04 -f websocket.lua
./luatool.py --port $luatool_tty --bar --delay 0.001 -f main.lua

./luatool.py --port /dev/cu.wchusbserial1410 --bar --delay 0.001 -f secrets_energy.lua
./luatool.py --port /dev/cu.wchusbserial1410 --bar --delay 0.001 -f wifi_ap_stop.lua
./luatool.py --port /dev/cu.wchusbserial1410 --bar --delay 0.001 -f wifi_cli_conf.lua
./luatool.py --port /dev/cu.wchusbserial1410 --bar --delay 0.001 -f wifi_cli_start.lua
./luatool.py --port /dev/cu.wchusbserial1410 --bar --delay 0.001 -f wifi_info.lua

./luatool.py --port $luatool_tty -l
read -p "Pas eu d'erreur, on redémarre et part à fond ?"
./luatool.py --port $luatool_tty --bar --delay 0.001 -f initz.lua -t init.lua
echo -e "\nC'est tout bon ;-)"
