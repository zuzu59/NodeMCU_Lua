#!/bin/bash
# Petit script pour télécharger du code en remote sur une grappe de NodeMCU
#zf191225.1802

# crée les tunnels SSH
source ./make_tunnels.sh

export ZFILE="0_cron.lua"
export ZRESTART=""
#export ZRESTART="--restart"

# On télécharge le fichier sur chaque nodemcu
echo -e "th1"
#./luatool.py --ip localhost:$TH1_PORT $ZRESTART -f $ZFILE
./luatool.py --ip localhost:$TH1_PORT --zrestart

echo -e "th2"
#./luatool.py --ip localhost:$TH2_PORT $ZRESTART -f $ZFILE
./luatool.py --ip localhost:$TH2_PORT --zrestart

echo -e "th3"
#./luatool.py --ip localhost:$TH3_PORT $ZRESTART -f $ZFILE
./luatool.py --ip localhost:$TH3_PORT --zrestart

echo -e "th4"
#./luatool.py --ip localhost:$TH4_PORT $ZRESTART -f $ZFILE
./luatool.py --ip localhost:$TH4_PORT --zrestart


#
