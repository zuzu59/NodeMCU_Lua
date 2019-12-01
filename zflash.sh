#!/bin/bash
#Petit script pour flasher facilement les NodeMCU avec un firmware

#ATTENTION: c'est pour ma structure, il faudra donc l'adapter

#zf191201.2321


#test si l'argument est vide
if [ -z "$1" ]
  then
    echo -e "\nSyntax:

./zflash.sh ../../Firmware/nodemcu-master-16-modules-2019-12-01-22-17-07-float.bin

"
    exit
fi

echo ---------- start zflash.sh

cd ./Tools/esptool-master

python esptool.py erase_flash
sleep 2
python esptool.py write_flash -fm dio 0x00000 $1
sleep 2
screen /dev/cu.wchusbserial1410 115200
