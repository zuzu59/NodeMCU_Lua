# Mesure d'humidité et de température

Petit projet pour mesurer l'humidité et la température pour l'afficher sur Grafana avec une DB InfluxDB. Comme par exemple pour monitorer l'humidité d'un local au cours du temps.


![Image of Yaktocat](https://zraw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/energy/transfo_courant_clip/img/20190908_134444.jpg)
toto

![Image of Yaktocat](https://zraw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/energy/transfo_courant_clip/img/20190908_134444.jpg)
tutu

![Image of Yaktocat](https://zraw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/energy/transfo_courant_clip/img/20190908_134444.jpg)
titi

![Image of Yaktocat](https://zraw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/energy/transfo_courant_clip/img/20190908_134444.jpg)
tata


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
On utilise un tout petit capteur, le HTU21D, d'humidité et de température I2C. Il est vraiment très bon marché (1.5$), simple à utiliser et super précis.

https://learn.sparkfun.com/tutorials/htu21d-humidity-sensor-hookup-guide/all

Datasheet:

https://cdn.sparkfun.com/assets/6/a/8/e/f/525778d4757b7f50398b4567.pdf

On arrive à le souder directement sur le NodeMCU, ce qui nous permet de faire un point de mesure décentralisé pour moins de 5.-

![Image of Yaktocat](https://zraw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/energy/transfo_courant_clip/img/20190908_134444.jpg)
soudure du module HTU21D directement sur le NodeMCU_Lua


## Installation

Il faut *flasher* le NodeMCU avec ce firmware:

https://github.com/zuzu59/NodeMCU_Lua/blob/master/Firmware/nodemcu-master-11-modules-2019-12-15-16-45-47-float.bin

Avec ces modules:
```
bit,file,gpio,http,i2c,net,node,rtctime,tmr,uart,wifi
 ```


## Utilisation


Exemple de sortie dans Grafana

https://snapshot.raintank.io/dashboard/snapshot/LUqdTJYLNuC6WatmJoN21yQSEQ0UJ0oy



### Distribution des rôles de NodeMCU

Comme on peut avoir plusieurs points de mesures à différents endroit dans le local, il n'y a qu'un seul fichier de *secrets*. C'est dans ce fichier de *secrets* qu'il y a l'information de l'adresse IP de la base de donnée InfluxDB et c'est l'id des NodeMCU qui sont enregistrés dans la DB InfluxDB !<br>

```
secrets_projet.lua
```



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


zf191216.2134


pense bête:

```
file.open("hello.lua","w+")
file.writeline([[print("hello nodemcu")]])
file.writeline([[print(node.heap())]])
file.close()
```
