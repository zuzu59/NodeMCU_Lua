# Mesure de hauteur d'eau dans un réservoir

zf200627.1325


<!-- TOC titleSize:2 tabSpaces:2 depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 skip:1 title:1 charForUnorderedList:* -->
## Table of Contents
* [Buts](#buts)
* [Astuces de mesures de la distance au moyen du senseur ultrason](#astuces-de-mesures-de-la-distance-au-moyen-du-senseur-ultrason)
  * [Schéma](#schéma)
  * [Astuces](#astuces)
* [Installation](#installation)
* [Utilisation](#utilisation)
  * [Upload Lua code](#upload-lua-code)
  * [Secrets pour le projet](#secrets-pour-le-projet)
  * [Rename initz.lua pour le boot automatique](#rename-initzlua-pour-le-boot-automatique)
  * [Utilisation de la console du NodeMCU en remote](#utilisation-de-la-console-du-nodemcu-en-remote)
  * [Visualisation sur Grafana/InfluxDB](#visualisation-sur-grafanainfluxdb)
<!-- /TOC -->

## Buts

Petit projet pour mesurer la hauteur d'eau dans un réservoir de 100l au moyen d'un senseur à ultrason utilisé pour de la robotique récréative.

Le but est de mesurer la distance entre le haut du bidon et la surface de l'eau dans le bidon et ainsi pouvoir en déduire le pourcentage de remplissage du bidon.

![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/water-level/water-level_ruru_1/img/20200625_163032.jpg)
Senseur à ultrason, très bon marché, permettant de mesure la distance


![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/water-level/water-level_ruru_1/img/20200625_160818.jpg)
NodeMCU autonome, alimenté ici par une batterie, faisant la lecture de la hauteur d'eau et envoyant le résultat dans une DB InfluxDB via le WIFI


![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/water-level/water-level_ruru_1/img/20200625_164022.jpg)
Banc test dans le jardin pour vérifier le bon fonctionnement du système

![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/water-level/water-level_ruru_1/img/grafana2020-06-25.16.54.32.png)
Graphique obtenu lors du banc test avec de l'eau dans le jardin


<br><br>
On peut voir ici, avec ce projet assez complet, toutes les possibilités offertes de la programmation des NodeMCU en LUA, en mode événementiel. <br>
Choses qui ne seraient pas possible si on l'avait fait en C++ (mode Arduino), comme par exemple:

* crontab, horloge pour les mesures
* envoi des données sur la DB InfluxDB
* serveur reverse TELNET, traversant tous les routers sans devoir en modifier la configuration, permettant d'accéder à la console série (USB) du NodeMCU

Toutes les fonctions sont bien séparées dans des scripts, cela *complexifie* le projet mais ce qui facilite la portabilité entre les projets et aussi sa mise au point.



## Astuces de mesures de la distance au moyen du senseur ultrason

Dans ce projet il y a 1x NodeMCU qui mesure la hauteur d'eau dans le bidon au moyen d'un senseur à ultrason utilisé pour de la robotique récréative très bon marché, 0.70FS

https://www.aliexpress.com/item/32477198302.html

https://cdn.sparkfun.com/datasheets/Sensors/Proximity/HCSR04.pdf

Il n'y a pas de *module* NodeMCU pour ce senseur, mais son utilisation en Lua est vraiment très simple, il suffit juste d'envoyer une *pulse* de 10uS sur la pin *trig* et de *connecter* une interruption du NodeMCU sur la pin *echo*. <br>
Après une simple règle de trois en relation avec la vitesse du son dans l'air et on a la distance en cm.


### Schéma

![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/water-level/water-level_ruru_1/schemas/schema.png)

Le schéma est vraiment très simple !


### Astuces

* La seul problématique dans ce projet c'est que le senseur DOIT absolument être alimenté en 5V et que le NodeMCU lui est en 3.3V. <br>
Il faut donc lui ajouter une petite résistance, R1, d'adaptation du niveau pour le signal pour l'interruption du NodeMCU.


## Installation

Il faut *flasher* le NodeMCU avec ce firmware:

https://github.com/zuzu59/NodeMCU_Lua/blob/master/Firmware/nodemcu-master-19-modules-2019-12-31-16-40-12-float.bin


Avec ces modules:

https://github.com/zuzu59/NodeMCU_Lua/blob/master/Firmware/nodemcu-master-19-modules-2019-12-31-16-40-12-float.pdf


## Utilisation

### Upload Lua code
Après avoir *flashé* le NodeMCU avec le bon *firmware* il faut télécharger tous les fichiers \*.lua sur le NodeMCU.


### Secrets pour le projet
Mais il faut aussi bien *remplir* et charger sur le NodeMCU, le fichier des secrets du projet:
```
secrets_project.lua
```

ainsi que le fichier des secrets pour le WIFI
```
secrets_wifi.lua
```
Tout en sachant que les variables utilisées pour les secrets sont utiles pour:

* **znode_chipid == nnn then**<br>
C'est l'id du NodeMCU que chaque NodeMCU ont gravé dans leur mémoire, on peut le lire avec cette commande:
```
=node.chipid()
```

* **node_id = "ttt"**<br>
C'est le nom de *fonction* du NodeMCU qui sera *visible* dans la DB InfluxDB

* **yellow_id = nn**<br>
C'est le *numéro* du NodeMCU que l'on indique sur une *petite étiquette jaune collée* sur le NodeMCU. Ce *numéro* permet par la suite de connaitre très facilement le numéro du *port* utilisé pour le *reverse telnet* quand on veut accéder à la console série du NodeMCU

* **-- thingspeak_url="http://api.thingspeak.com/update?api_key=kkk"**<br>
Pas utilisé dans ce projet

* **influxdb_url="http://uuu:8086/write?db=ddd&u=admin&p=ppp"**<br>
Secrets utilisés pour envoyer des données sur le DB InfluxDB

* **console_host = "uuu"   console_port = 23000+yellow_id**<br>
Serveur utilisé pour le *tremplin* du reverse telnet utilisé pour accéder à la console série du NodeMCU au moyen d'un *socat*. L'information d'utilisation se trouve dans le fichier 0_tst5_socat.lua

* **-- zdyndns_host = "hhh"  zdyndns_port = nnn**<br>
Pas utilisé dans ce projet


### Rename initz.lua pour le boot automatique
Ne pas oublier après avoir vérifié que tout fonctionne bien de *renommer* le fichier **initz.lua** en **init.lua** afin que quand le NodeMCU puisse démarrer automatiquement le code et bien fonctionner de manière autonome.


### Utilisation de la console du NodeMCU en remote

Très pratique pour le debug, on peut directement modifier le code source Lua du NodeMCU en remote via un *reverse telnet*. Plus d'info dans le fichier 0_tst5_socat.lua.
On peut aussi modifier le code Lua du NodeMCU en remote avec l'utilitaire *luatools.py*


### Visualisation sur Grafana/InfluxDB
![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/water-level/water-level_ruru_1/img/grafana2020-06-25.16.54.32.png)
Graphique obtenu lors du banc test avec de l'eau dans le jardin

La totale en détail

https://github.com/zuzu59/docker-influxdb-grafana





pense bête:

```
file.open("hello.lua","w+")
file.writeline([[print("hello nodemcu")]])
file.writeline([[print(node.heap())]])
file.close()
```
