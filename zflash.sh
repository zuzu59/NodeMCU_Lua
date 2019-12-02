#!/bin/bash
#Petit script pour flasher facilement les NodeMCU avec un firmware

#ATTENTION: c'est pour ma structure, il faudra donc l'adapter

#zf191202.1937


#test si l'argument est vide
if [ -z "$1" ]
  then
    echo -e "\nSyntax:

Pour le dernier firmware à la mode:
./zflash.sh ../../Firmware/nodemcu-master-16-modules-2019-12-01-22-17-07-float.bin

Pour l'ancien qui supporte encore le DS18B20:
./zflash.sh ../../Firmware/nodemcu-master-20-modules-2019-06-01-12-50-39-float.bin



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
