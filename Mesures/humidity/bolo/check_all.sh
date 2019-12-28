#!/bin/bash
# Petit script pour contrôler en remote les versions d'une grappe de NodeMCU installés
#zf191226.1241

# crée les tunnels SSH
source ./make_tunnels.sh go

# On liste les fichiers de chaque nodemcu
echo -e "th1"
./luatool.py --ip localhost:$TH1_PORT --list

echo -e "th2"
./luatool.py --ip localhost:$TH2_PORT --list

echo -e "th3"
./luatool.py --ip localhost:$TH3_PORT --list

echo -e "th4"
./luatool.py --ip localhost:$TH4_PORT --list
