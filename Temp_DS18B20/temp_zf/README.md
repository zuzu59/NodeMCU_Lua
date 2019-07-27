# temp_zf

Petit projet pour mesurer la température intérieur et extérieur chez moi, avec des capteurs de température 1-Wire DS18B20, et  l'afficher sur ThingSpeak.


## Astuces de lecture

Dans ce projet il y a 3x NodeMCU séparés qui mesurent 3x points de température séparées:

* température intérieure dans la chambre à coucher à l'étage
* température extérieur au rez sud (à l'ombre)
* température extérieur au rez nord (à l'ombre)

Le NodeMCU de la mesure extérieure sud fait office de hub des deux autres mesures de températures et, envoie en même temps les 3x mesures de températures à Thingspeak. Ceci afin de les avoir tous dans le même channel (on économise les channels).<br>
Cela permet de mesurer des températures éloignées dans la maison en utilisant le WIFI comme câble de liaison entre les sondes !

Tous se passe dans les scripts a1, a2, a3 et a4.lua (**Attention en cours de refactorisation !**)


## Installation

Il faut *flasher* le NodeMCU avec ce firmware:

https://github.com/zuzu59/NodeMCU_Lua/blob/master/Firmware/nodemcu-master-20-modules-2019-07-01-06-35-13-float.bin


Avec ces modules:

```
adc ds18b20 file gpio http i2c mdns mqtt net
node ow pcm rtctime sntp spi tmr uart wifi ws2812
```


## Utilisation

Comme les mesures de températures sont faites avec 3x NodeMCU différents, il y a donc 3x fichiers de *secrets*. C'est dans ces fichiers de *secrets* qu'il y a l'information de l'adresse IP du NodeMCU qui fait office de *hub* !

```
secrets_temp_zf_int.lua
secrets_temp_zf_out_sud.lua
secrets_temp_zf_out_nord.lua
```


## Visualisation sur ThingSpeak

https://thingspeak.com/channels/817940


zf190727.1004
