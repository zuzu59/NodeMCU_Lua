#!/bin/bash
#Petit script pour flasher facilement les NodeMCU
#zf181015.1147

cd ./Tools/esptool-master

python esptool.py erase_flash
sleep 
python esptool.py write_flash -fm dio 0x00000 ../../Firmware/nodemcu-master-13-modules-2018-10-11-16-35-53-float.bin
sleep 1
screen /dev/cu.wchusbserial1410 115200
