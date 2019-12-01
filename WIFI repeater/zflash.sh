#!/bin/bash
#Petit script pour flasher facilement les NodeMCU avec le firmware WIFI repeater

#ATTENTION: c'est pour ma structure, il faudra donc l'adapter

#zf191201.1243

esptool_path='../Tools/esptool-master'

#test si l'argument est vide
if [ -z "$1" ]
  then
    echo -e "\nSyntax:

./zflash.sh go

"
    exit
fi


echo ---------- start zflash.sh

python $esptool_path/esptool.py erase_flash
sleep 2

python $esptool_path/esptool.py write_flash -fs 4MB -ff 80m -fm dio 0x00000 0x00000.bin 0x02000 0x02000.bin

sleep 2
screen /dev/cu.wchusbserial1410 115200
