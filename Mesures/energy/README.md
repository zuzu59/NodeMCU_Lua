# temp_zf

Petit projet pour mesurer la consommation électrique en temps réel chez moi avec un NodeMCU en LUA, et  l'afficher sur ThingSpeak.

![Image of Yaktocat](.jpg)

![Image of Yaktocat](.png)

On peut voir, avec ce projet assez complet, toutes les possibilités offertes de la programmation des NodeMCU en LUA, en mode événementiel. <br>
Choses qui ne seraient pas possible si on l'avait fait en C++ (mode Arduino), comme par exemple:

* serveur WEB Active Server Pages ZYX, permet de faire des pages HTML dynamique avec du code LUA in line
* serveur WEB service pour le HUB (API GET)
* serveur WEB pour l'affichage de la consommation électrique
* serveur WEB pour l'IDE, modification du code source en remote directement depuis une page WEB, pas besoin d'IDE
* crontab, horloge pour les mesures de la consommation
* serveur TELNET, utilisation de la console en remote pour le debug

Toutes les fonctions sont bien séparées dans des scripts, ce qui facilite la portabilité entre les projets mais aussi sa mise au point.



## Astuces de mesures

Dans ce projet il y a 1x NodeMCU qui mesure la consommation électrique en détectant simplement le petite LED du compteur électrique
:

Il envoie la puissance sur le NodeMCU de la mesure **extérieure sud** fait office de hub des deux autres mesures de températures et, envoie en même temps les 4x mesures à Thingspeak. Ceci afin de les avoir tous dans le même channel (on économise les channels).<br>
Cela permet de mesurer des valeurs physiques éloignées dans la maison en utilisant le WIFI comme câble de liaison entre les sondes !


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

Comme la mesure de consommation est faite avec 1x NodeMCU, il y a donc 1x fichiers de *secrets*. C'est dans ce fichier de *secrets* qu'il y a l'information de l'adresse IP du NodeMCU qui fait office de *hub* !<br>

```
secrets_energy.lua
```

C'est aussi là qu'il y a le *numéro du field* (zfield), c'est à dire le rôle joué par le NodeMCU_Lua:

* **4**, consommation électrique

Et c'est le NodeMCu de mesure de température *sud* qui fait office de *hub*, qui concentre les mesures et les envoie en une fois à Thingspeek !


**faut encore modifier le readme depuis ici ! zf190803.1917**

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


zf190803.1917
