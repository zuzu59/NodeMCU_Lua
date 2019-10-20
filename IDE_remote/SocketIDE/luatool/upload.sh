#!/bin/bash
# Petit script pour télécharger facilement tout le binz
#zf191020.1837

# S'il y a des erreurs lors d'un téléchargement, il faut simplement augmenter un peu le délai !

chmod +x luatool.py
./luatool.py --port /dev/cu.wchusbserial1410 -l
./luatool.py --port /dev/cu.wchusbserial1410 -w
./luatool.py --port /dev/cu.wchusbserial1410 -l
./luatool.py --port /dev/cu.wchusbserial1410 --delay 0.001 -f boot.lua
./luatool.py --port /dev/cu.wchusbserial1410 --delay 0.001 -f boot2.lua
./luatool.py --port /dev/cu.wchusbserial1410 --delay 0.03 -f flash_led_xfois.lua
./luatool.py --port /dev/cu.wchusbserial1410 --delay 0.001 -f initz.lua
./luatool.py --port /dev/cu.wchusbserial1410 --delay 0.001 -f secrets_energy.lua
./luatool.py --port /dev/cu.wchusbserial1410 --delay 0.001 -f wifi_ap_stop.lua
./luatool.py --port /dev/cu.wchusbserial1410 --delay 0.001 -f wifi_cli_conf.lua
./luatool.py --port /dev/cu.wchusbserial1410 --delay 0.001 -f wifi_cli_start.lua
./luatool.py --port /dev/cu.wchusbserial1410 --delay 0.001 -f wifi_info.lua
./luatool.py --port /dev/cu.wchusbserial1410 --delay 0.04 -f telnet_srv2.lua
./luatool.py --port /dev/cu.wchusbserial1410 -l
