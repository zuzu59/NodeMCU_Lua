# temp_zf

## Petit projet pour mesurer la température, avec des capteurs de température 1-Wire DS18B20, et  l'afficher sur ThingSpeak


## Astuces de lecture

Tous se passe dans: a1, a2, a3 et a4.lua !


## Installation
Il faut *flasher* le NodeMCU avec ce firmware:

https://github.com/zuzu59/NodeMCU_Lua/blob/master/Firmware/nodemcu-master-20-modules-2019-07-01-06-35-13-float.bin


Avec ces modules:

```
adc ds18b20 file gpio http i2c mdns mqtt net node ow pcm rtctime sntp spi tmr uart wifi ws2812
```


## Visualisation sur ThingSpeak

https://thingspeak.com/channels/817940


zf190706.1450
