# Mesure d'humidité de référence par psychométrie

zf191203.0022

Petit projet pour mesurer l'humidité de référence, par exemple pour l'étalonnage d'un hygromètre, par la méthode de la psychométrie.

https://fr.wikipedia.org/wiki/Psychrom%C3%A9trie
http://meteonet.info/html/table_psychrometrique.html
https://www.abcclim.net/table-psychrometrique.html

Principe simple, on mesure la température de deux thermomètres, un recouvert d'un manchon humide et l'autre à l'air libre. La différence de températures indique, via une table de conversion, l'humidité relative de l'air.


![Image of Yaktocat](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/psychrometre/img/20191202_232755.jpg)

Mon petit psychromètre à base de NodeMCU & DS18B20


![Image of Yaktocat](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/psychrometre/img/20191202_232703.jpg)


Les températures mesurées en fonctionnement

![Image of Yaktocat](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/psychrometre/img/20191202_232904.jpg)

Et le résultat à lire dans une table psychrométrique


## Astuces de mesures

Dans ce projet on utilise deux capteurs de température de précision DS18B20 en mode alimentation parasite (seulement deux fils, alimentation comprise). La lecture des températures se fait pour l'instant dans la console série !


## Installation

Il faut *flasher* le NodeMCU avec ce firmware:

https://github.com/zuzu59/NodeMCU_Lua/blob/master/Firmware/nodemcu-master-20-modules-2019-06-01-12-50-39-float.bin

Avec ces modules:

```
adc bit ds18b20 file gpio http i2c mqtt net node ow pcm rtctime sntp spi tmr uart wifi ws2812
```


## Utilisation

Le code utilisé ici est de la récupération d'un autre projet (temp_solar_zf), 99% est inutile !

Ce n'est que le script *a2.lua* qui est utilisé ici pour lire les températures dans la console. Le but n'était pas de faire du code mais d'avoir très rapidement un hygromètre d'étalonnage ;-)

Un jour quand j'aurai le temps, on ne sait jamais, je terminerai ce projet et lui ferai un joli interface WEB avec graphage sur un Grafana/InfluxDB ;-)))
