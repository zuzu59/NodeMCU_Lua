# tst_ds18b20

## Petit test pour mesurer la température avec des capteurs one-wire DS18B20 et les afficher sur ThingSpeak

dofile("boot.lua")
dofile("a1.lua")



## Installation
Il faut flasher le NodeMCU avec ce firmware:

https://github.com/zuzu59/NodeMCU_Lua/blob/master/Firmware/nodemcu-master-20-modules-2019-06-01-12-50-39-float.bin

Avec ces modules:

adc bit ds18b20 file gpio http i2c mqtt net node ow pcm rtctime sntp spi tmr uart wifi ws2812

zf190617.1358
