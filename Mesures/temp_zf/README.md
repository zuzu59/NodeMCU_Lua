# temp_zf

Petit projet pour mesurer la température intérieure et extérieure chez moi, avec des capteurs de température 1-Wire DS18B20, et  l'afficher sur ThingSpeak.

![Image of Yaktocat](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Temp_DS18B20/temp_zf/img/20190728_122840.jpg)

![Image of Yaktocat](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Temp_DS18B20/temp_zf/img/Capture%20d%E2%80%99%C3%A9cran%202019-07-28%20%C3%A0%2012.31.14.png)

On peut voir, avec ce projet assez complet, toutes les possibilités offertes de la programmation des NodeMCU en LUA, en mode événementiel. <br>
Choses qui ne seraient pas possible si on l'avait fait en C++ (mode Arduino), comme par exemple:

* serveur WEB Active Server Pages ZYX, permet de faire des pages HTML dynamique avec du code LUA in line
* serveur WEB service pour le HUB (API GET)
* serveur WEB pour l'affichage des températures
* serveur WEB pour l'IDE, modification du code source en remote directement depuis une page WEB, pas besoin d'IDE
* crontab, horloge pour les mesures de température
* serveur TELNET, utilisation de la console en remote pour le debug

Toutes les fonctions sont bien séparées dans des scripts, ce qui facilite la portabilité entre les projets mais aussi sa mise au point.



## Astuces de mesures

Dans ce projet il y a 3x NodeMCU séparés qui mesurent 3x points de température séparées:

* température intérieure dans la chambre à coucher à l'étage
* température extérieur au rez sud (à l'ombre)
* température extérieur au rez nord (à l'ombre)

Le NodeMCU de la mesure **extérieure sud** fait office de hub des deux autres mesures de températures et, envoie en même temps les 3x mesures de températures à Thingspeak. Ceci afin de les avoir tous dans le même channel (on économise les channels).<br>
Cela permet de mesurer des températures éloignées dans la maison en utilisant le WIFI comme câble de liaison entre les sondes !


## Installation

Il faut *flasher* le NodeMCU avec ce firmware:

https://github.com/zuzu59/NodeMCU_Lua/blob/master/Firmware/nodemcu-master-20-modules-2019-07-01-06-35-13-float.bin


Avec ces modules:

```
adc ds18b20 file gpio http i2c mdns mqtt net
node ow pcm rtctime sntp spi tmr uart wifi ws2812
```


## Utilisation

### Distribution des rôles de NodeMCU

Comme les mesures de températures sont faites avec 3x NodeMCU différents, il y a donc 3x fichiers de *secrets*. C'est dans ces fichiers de *secrets* qu'il y a l'information de l'adresse IP du NodeMCU qui fait office de *hub* !<br>

```
secrets_temp_int_1er.lua
secrets_temp_out_sud.lua
secrets_temp_out_nord.lua
```

C'est aussi là qu'il y a le *numéro du field* (zfield), c'est à dire le rôle joué par le NodeMCU_Lua:

* **1**, température intérieure dans la chambre à coucher à l'étage
* **2**, température extérieur au rez sud (à l'ombre)
* **3**, température extérieur au rez nord (à l'ombre)

Et c'est le **2** qui fait office de *hub*, qui concentre les mesures de température et les envoie en une fois à Thingspeek !


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


zf190728.1242
