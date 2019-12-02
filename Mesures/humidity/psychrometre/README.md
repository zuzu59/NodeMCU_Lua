# Mesure d'humidité de référence par psychométrie

zf191203.0009

Petit projet pour mesurer l'humidité de référence, par exemple pour l'étalonnage d'un hygromètre, par la méthode de la psychométrie.

https://fr.wikipedia.org/wiki/Psychrom%C3%A9trie

Principe simple, on mesure la température de deux thermomètres, un recouvert d'un manchon humide et l'autre à l'air libre. La différence de températures indique, via une table de conversion, l'humidité relative de l'air.


![Image of Yaktocat](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/psychrometre/img/20191202_232755.jpg)

Mon petit psychromètre à base de NodeMCU & DS18B20


![Image of Yaktocat](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/psychrometre/img/20191202_232703.jpg)


Les températures mesurées en fonctionnement

![Image of Yaktocat](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/psychrometre/img/20191202_232904.jpg)

Et le résultat à lire dans une table psychrométrique




<br><bR>
On peut voir ici, avec ce projet assez complet, toutes les possibilités offertes de la programmation des NodeMCU en LUA, en mode événementiel. <br>
Choses qui ne seraient pas possible si on l'avait fait en C++ (mode Arduino), comme par exemple:

* serveur WEB Active Server Pages ZYX, permet de faire des pages HTML dynamiques avec du code LUA in line. Les pages HTML sont sauve dans la FLASH du NodeMCU
* serveur WEB service pour le HUB concentrateur de mesures de différents NodeMCU (API GET)
* serveur WEB pour l'affichage de l'humidité et de la température
* serveur WEB pour l'IDE, modification du code source en remote directement depuis une page WEB, pas besoin d'IDE
* crontab, horloge pour les mesures
* serveur TELNET, utilisation de la console en remote pour le dépannage

Toutes les fonctions sont bien séparées dans des scripts, cela *complexifie* le projet mais cela facilite la portabilité entre les projets et aussi sa mise au point.



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

Le code utilisé est de la récupération d'un autre projet, 99% est inutile !

Ce n'est que le script a2.lua qui est utilisé ici pour lire les températures dans la console. Le but n'était pas de faire du code mais d'avoir très rapidement un hygromètre d'étalonnage ;-)

Un jour quand j'aurai le temps, on ne sait jamais, je terminerai ce projet et lui ferai un joli interface WEB avec graphage sur un Grafana/InfluxDB ;-)))








<br>
<br>
<br>
<br>
<br>
<br>
**ATTENTION, readme pas encore terminé, il faut encore modifier le readme depuis ici ! zf190922.1740**
<br>
<br>
<br>
<br>
<br>
<br>

### Affichage des températures en local sur le NodeMCU

On peut lire la température directement sur le NodeMCU au moyen de cet url (il faut modifier l'adresse IP du NodeMCU en question):

nodemcu 28 int, http://192.168.0.171/disp_temp.html

nodemcu 29 sud, http://192.168.0.180/disp_temp.html

nodemcu 30 nord, http://192.168.0.105/disp_temp.html


### Affichage du petit serveur web du NodeMCU_Lua

Chaque NodeMCU a son propre serveur WEB, on peut l'accéder simplement depuis son adresse IP:

nodemcu 28 int, http://192.168.0.171

nodemcu 29 sud, http://192.168.0.180

nodemcu 30 nord, http://192.168.0.105


### Modification du code source du NodeMCU en remote

Très pratique pour le debug, on peut directement modifier le code source Lua du NodeMCU en remote avec cet url:

nodemcu 28 int, http://192.168.0.171:88

nodemcu 29 sud, http://192.168.0.180:88

nodemcu 30 sord, http://192.168.0.105:88


### Utilisation de la console du NodeMCU en remote

Très pratique pour le debug, on peut accéder à la console du NodeMCU en remote avec telnet:

nodemcu 28 int, **telnet -rN 192.168.0.171**

nodemcu 29 sud, **telnet -rN 192.168.0.180**

nodemcu 30 nord, **telnet -rN 192.168.0.105**


## Visualisation sur ThingSpeak
La totale en détail
https://thingspeak.com/channels/817940

Seulement la corrélation entre les trois température
https://thingspeak.com/apps/plugins/300559




pense bête:

```
file.open("hello.lua","w+")
file.writeline([[print("hello nodemcu")]])
file.writeline([[print(node.heap())]])
file.close()
```
