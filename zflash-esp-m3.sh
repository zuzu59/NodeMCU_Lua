#!/bin/bash
#Petit script pour flasher facilement les ESP-M3 avec un firmware

#ATTENTION: c'est pour ma structure, il faudra donc l'adapter

#zf200720.1959


#test si l'argument est vide
if [ -z "$1" ]
  then
    echo -e "\nSyntax:

Pour le dernier firmware à la mode:
./zflash-esp-m3.sh ../../Firmware/nodemcu-master-16-modules-2019-12-01-22-17-07-float.bin
./zflash-esp-m3.sh ../../Firmware/nodemcu-master-11-modules-2019-12-15-16-45-47-float.bin
./zflash-esp-m3.sh ../../Firmware/nodemcu-master-18-modules-2019-12-17-20-28-32-float.bin
./zflash-esp-m3.sh ../../Firmware/nodemcu-master-12-modules-2019-12-21-11-05-58-float.bin
./zflash-esp-m3.sh ../../Firmware/nodemcu-master-19-modules-2019-12-31-16-40-12-float.bin
./zflash-esp-m3.sh ../../Firmware/nodemcu-master-19-modules-2020-06-17-17-22-55-float.bin
./zflash-esp-m3.sh ../../Firmware/nodemcu-master-19-modules-2020-06-17-18-07-17-float.bin

Pour l'ancien qui supporte encore le DS18B20:
./zflash-esp-m3.sh ../../Firmware/nodemcu-master-20-modules-2019-06-01-12-50-39-float.bin



"
    exit
fi

echo ---------- start zflash.sh

cd ./Tools/esptool-master

python3 esptool.py flash_id
sleep 2

python3 esptool.py erase_flash
sleep 2

python3 esptool.py write_flash -fm dout 0x00000 $1
sleep 2
screen /dev/cu.wchusbserial1410 115200
