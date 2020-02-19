#!/bin/bash
# petit script provisoire pour se connecter sur les NodeMCU en reverse telnet
# zf200219.1710


#test si l'argument est vide
if [ -z "$1" ]
  then
    echo -e "\nUsage:

./rtelnet.sh socket
./rtelnet.sh 23047

"
    exit
fi

# on établit le serveur reverse telnet
ssh ubuntu@www.zuzutest.ml socat TCP-LISTEN:$1,reuseaddr,fork TCP-LISTEN:24047,reuseaddr,bind=127.0.0.1 &

read -p "On attend un certain temps que le NodeMCU se connecte ;-)"

# on se connecte en telnet sur le NodeMCU
ssh ubuntu@www.zuzutest.ml telnet -r localhost 24047

# on tue le serveur reverse telnet
ssh ubuntu@www.zuzutest.ml killall -9 socat
