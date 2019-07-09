# temp_zf

Petit projet pour mesurer la température, avec des capteurs de température 1-Wire DS18B20, et  l'afficher sur ThingSpeak.


## Astuces de lecture

Dans ce projet il y a 3x NodeMCU séparés qui mesurent 3x points de température séparées:

* température intérieure dans la chambre à coucher à l'étage
* température extérieur au rez nord
* température extérieur au rez sud

Le NodeMCU de la mesure intérieure fait office de concentrateur des deux mesures de températures extérieures et envoie en même temps les 3x mesures de températures à Thingspeak, afin de les avoir tous dans le même channel. Cela permet de mesurer des températures éloignées dans la maison en utilisant le WIFI comme câble de liaison entre les sondes !

Tous se passe dans les scripts a1, a2, a3 et a4.lua


## Installation

Il faut *flasher* le NodeMCU avec ce firmware:

https://github.com/zuzu59/NodeMCU_Lua/blob/master/Firmware/nodemcu-master-20-modules-2019-07-01-06-35-13-float.bin


Avec ces modules:

```
adc ds18b20 file gpio http i2c mdns mqtt net
node ow pcm rtctime sntp spi tmr uart wifi ws2812
```


## Visualisation sur ThingSpeak

https://thingspeak.com/channels/817940


zf190709.2135
