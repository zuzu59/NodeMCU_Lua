#!/bin/bash
# Petit script pour créer tous les tunnels SSH sur les NodeMCU en remote
# zf191225.1352

# Définition des variables
TREMPLIN_SSH=www.zuzutest.ml
OPIZ_PORT=20223

TH1_IP=192.168.8.100
TH1_PORT=23001
TH2_IP=192.168.8.101
TH2_PORT=23002
TH3_IP=192.168.8.102
TH3_PORT=23003
TH4_IP=192.168.8.103
TH4_PORT=23004


# On tue tous les tunnels ssh
echo "kill"
killall -9 ssh
sleep 3

# On crée le tunnel sur la passerelle ssh 20223
echo "first"
ssh -y -y -N -T -L $OPIZ_PORT:localhost:$OPIZ_PORT ubuntu@$TREMPLIN_SSH &
sleep 3

# On crée tous les tunnels sur les nodemcu
echo "second"
ssh -y -y -N -T -L $TH1_PORT:$TH1_IP:23 ubuntu@localhost -p $OPIZ_PORT &
ssh -y -y -N -T -L $TH2_PORT:$TH2_IP:23 ubuntu@localhost -p $OPIZ_PORT &
ssh -y -y -N -T -L $TH3_PORT:$TH3_IP:23 ubuntu@localhost -p $OPIZ_PORT &
ssh -y -y -N -T -L $TH4_PORT:$TH4_IP:23 ubuntu@localhost -p $OPIZ_PORT &
sleep 3

echo "end"
ps ax |grep ssh

# On liste les fichiers de chaque nodemcu
#echo -e "th1"
#/luatool.py --ip localhost:$TH1_PORT --list
