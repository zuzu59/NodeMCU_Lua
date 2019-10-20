#!/bin/bash
# Petit script pour télécharger facilement tout le binz
#zf191020.1745

chmod +x luatool.py
./luatool.py --port /dev/cu.wchusbserial1410 -l
./luatool.py --port /dev/cu.wchusbserial1410 -f websocket.lua
./luatool.py --port /dev/cu.wchusbserial1410 -f main.lua
./luatool.py --port /dev/cu.wchusbserial1410 -f init.lua
./luatool.py --port /dev/cu.wchusbserial1410 -l
