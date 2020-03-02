
#!/bin/bash
# petit script provisoire pour se connecter sur les NodeMCU en reverse telnet
# zf200302.0903

#test si l'argument est vide
if [ -z "$1" ]
  then
    echo -e "\nUsage:

./rtelnet.sh socket
./rtelnet.sh 23047
./rtelnet.sh 23056

"
    exit
fi

echo "On tue le serveur reverse telnet en remote"
ssh ubuntu@www.zuzutest.ml killall -9 socat
sleep 1

echo "On tue le tunnel en local (ATTENTION, tue tous les ssh !)"
killall -9 ssh
sleep 1

echo "On établit le serveur reverse telnet"
ssh ubuntu@www.zuzutest.ml socat TCP-LISTEN:$1,reuseaddr,fork TCP-LISTEN:23000,reuseaddr,bind=127.0.0.1 &
#ssh ubuntu@www.zuzutest.ml socat TCP-LISTEN:23047,reuseaddr,fork TCP-LISTEN:23000,reuseaddr,bind=127.0.0.1 &

watch -n 1 'ssh ubuntu@www.zuzutest.ml netstat -nat |grep 230'
sleep 1

echo "On crée le tunnel sur la console du NodeMCU"
ssh -N -L 23000:localhost:23000 ubuntu@www.zuzutest.ml &
sleep 1

echo "On se connecte en telnet sur le NodeMCU"
telnet -r localhost 23000

read -p "Voulez-vous tuer la connexion ?"

echo "On tue le serveur reverse telnet en remote"
ssh ubuntu@www.zuzutest.ml killall -9 socat

echo "On tue le tunnel en local (ATTENTION, tue tous les ssh !)"
killall -9 ssh



