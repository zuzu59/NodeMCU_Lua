# energy

Petit projet pour mesurer la consommation électrique en temps réel chez moi avec un NodeMCU en LUA, et  l'afficher sur Grafana avec une DB InfluxDB.

![Image of Yaktocat](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/energy/img/20190805_134510.jpg)
Vue globale de mon installation prototype :-)

![Image of Yaktocat](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/energy/img/20190805_134459.jpg)
La photo résistance LDR est juste collée avec du scotch sur la LED du compteur électrique !

![Image of Yaktocat](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/energy/img/20190805_134504.jpg)
C'est mon NodeMCU de banc tests, il y a beaucoup trop de choses dessus, normalement il n'y a qu'une résistance de pull down à ajouter à la LDR et c'est tout !

![Image of Yaktocat](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/energy/img/Screenshot_20190807-221648_Chrome.jpg)
On voit ici la régulation thermique de mon four lors de la cuisson d'une excellente tarte aux groseilles :-)

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

Dans ce projet il y a 1x NodeMCU qui mesure la consommation électrique en détectant simplement le petite LED du compteur électrique avec une photo résistance LDR. A chaque éclairage de la LED du compteur électrique, il y a 100Wh qui ont été consommée. Il suffit alors d'un simple petit calcul (3600 divisé par la durée entre deux impulsions et multiplié par 100W) pour retrouver la puissance instantanée mesurée.



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

Comme la mesure de consommation est faite avec 1x NodeMCU, il y a donc 1x fichiers de *secrets*. C'est dans ce fichier de *secrets* qu'il y a l'information de l'adresse IP de la base de donnée InfluxDB !<br>

```
secrets_energy.lua
```

C'est aussi là qu'il y a le *numéro du field* (zfield), c'est à dire le rôle joué par le NodeMCU_Lua:

* **4**, consommation électrique




**ATTENTION, readme pas encore terminé, il faut encore modifier le readme depuis ici ! zf190807.2100**

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


zf190908.2147


pense bête:

```
file.open("hello.lua","w+")
file.writeline([[print("hello nodemcu")]])
file.writeline([[print(node.heap())]])
file.close()
```
