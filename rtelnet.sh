#!/bin/bash
# petit script provisoire pour se connecter sur les NodeMCU en reverse telnet
# zf200221.1336


#test si l'argument est vide
if [ -z "$1" ]
  then
    echo -e "\nUsage:

./rtelnet.sh socket
./rtelnet.sh 23047

"
    exit
fi

# on tue le serveur reverse telnet
ssh ubuntu@www.zuzutest.ml killall -9 socat

# on tue le tunnel
killall -9 ssh



# on établit le serveur reverse telnet
ssh ubuntu@www.zuzutest.ml socat TCP-LISTEN:$1,reuseaddr,fork TCP-LISTEN:23000,reuseaddr,bind=127.0.0.1 &

watch -n 1 'ssh ubuntu@www.zuzutest.ml netstat -nat |grep 230'


# on crée le tunnel sur la console du NodeMCU
ssh -N -L 23000:localhost:23000 ubuntu@www.zuzutest.ml &



ça ne marche pas bien ici :-(



# on se connecte en telnet sur le NodeMCU
#ssh ubuntu@www.zuzutest.ml telnet -r localhost 24047
telnet -r localhost 23000

read -p "Voulez-vous tuer la connexion ?"

# on tue le serveur reverse telnet
ssh ubuntu@www.zuzutest.ml killall -9 socat

# on tue le tunnel
killall -9 ssh
