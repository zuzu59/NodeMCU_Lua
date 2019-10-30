#!/bin/bash
# Petit script pour tester tout le binz via le WIFI
#zf191020.1954

# S'il y a des erreurs lors d'un téléchargement, il faut simplement augmenter un peu le délai !

IP="192.168.0.157"

chmod +x luatool.py

./luatool.py --ip $IP -l
read -p "continue ?"
./luatool.py --ip $IP --delete toto.lua
read -p "continue ?"
./luatool.py --ip $IP -l
read -p "continue ?"
./luatool.py --ip $IP -f toto.lua -d
read -p "continue ?"
./luatool.py --ip $IP -l
read -p "continue ?"
./luatool.py --ip $IP --delete toto.lua
read -p "continue ?"
./luatool.py --ip $IP -l
