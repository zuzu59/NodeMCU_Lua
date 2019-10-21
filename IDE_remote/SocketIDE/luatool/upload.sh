#!/bin/bash
# Petit script pour télécharger facilement tout le binz
#zf191021.0844

# S'il y a des erreurs lors d'un téléchargement, il faut simplement augmenter un peu le délai !
# Il est préférable de télécharger en premier les *gros* fichiers .lua !

#ATTENTION: cela efface tout le NodeMCU !

read -p "ATTENTION, cela va effacer tout le NodeMCU !"
read -p "Etes-vous vraiment certain ?"

chmod +x luatool.py
./luatool.py --port /dev/cu.wchusbserial1410 --zrestart
sleep 0.5
./luatool.py --port /dev/cu.wchusbserial1410 -w
./luatool.py --port /dev/cu.wchusbserial1410 -l

./luatool.py --port /dev/cu.wchusbserial1410 --bar --delay 0.06 --src telnet_srv2.lua
./luatool.py --port /dev/cu.wchusbserial1410 --bar --delay 0.001 --src boot.lua
./luatool.py --port /dev/cu.wchusbserial1410 --bar --delay 0.001 --src boot2.lua
./luatool.py --port /dev/cu.wchusbserial1410 --bar --delay 0.03 --src flash_led_xfois.lua
./luatool.py --port /dev/cu.wchusbserial1410 --bar --delay 0.001 --src secrets_energy.lua
./luatool.py --port /dev/cu.wchusbserial1410 --bar --delay 0.001 --src wifi_ap_stop.lua
./luatool.py --port /dev/cu.wchusbserial1410 --bar --delay 0.001 --src wifi_cli_conf.lua
./luatool.py --port /dev/cu.wchusbserial1410 --bar --delay 0.001 --src wifi_cli_start.lua
./luatool.py --port /dev/cu.wchusbserial1410 --bar --delay 0.001 --src wifi_info.lua
./luatool.py --port /dev/cu.wchusbserial1410 --bar --delay 0.001 --src initz.lua --dest init.lua
./luatool.py --port /dev/cu.wchusbserial1410 -l
./luatool.py --port /dev/cu.wchusbserial1410 --zrestart
