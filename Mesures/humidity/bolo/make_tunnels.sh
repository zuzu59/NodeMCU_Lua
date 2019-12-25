#!/bin/bash
# Petit script pour créer tous les tunnels SSH sur les NodeMCU en remote
# zf191225.1352

echo -e "
Usage:

source ./make_tunnels.sh

"
read -p "continue ?"



# Définition des variables
export TREMPLIN_SSH=www.zuzutest.ml
export OPIZ_PORT=20223

export TH1_IP=192.168.8.100
export TH1_PORT=23001
export TH2_IP=192.168.8.101
export TH2_PORT=23002
export TH3_IP=192.168.8.102
export TH3_PORT=23003
export TH4_IP=192.168.8.103
export TH4_PORT=23004


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
