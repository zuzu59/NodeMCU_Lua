# solar_zf

## Petit projet pour mesurer les paramètres de ma installation solaire thermique pour mon ECS (Eau Chaude Solaire) et les afficher sur ThingSpeak

Pour l'instant ce n'est qu'un test, mais je vais utiliser des capteurs de température One Wire DS18B20 ;-)

telnet -rN 192.168.0.173

dofile("boot.lua")
dofile("a3.lua")
dofile("a4.lua")



## Installation
Il faut flasher le NodeMCU avec ce firmware:

https://github.com/zuzu59/NodeMCU_Lua/blob/master/Firmware/nodemcu-master-20-modules-2019-06-01-12-50-39-float.bin

Avec ces modules:

adc bit ds18b20 file gpio http i2c mqtt net node ow pcm rtctime sntp spi tmr uart wifi ws2812

zf190617.1358
