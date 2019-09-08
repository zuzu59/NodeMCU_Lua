# solar_pv_energy

Petit projet pour mesurer la production électrique d'une installation solaire photovoltaïque monophasé avec un NodeMCU en LUA, et  l'afficher sur Grafana avec une DB InfluxDB.

![Image of Yaktocat](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/solar_pv_energy/img/20190907_170403.jpg)
Vue globale de mon installation solaire prototype (2x panneaux de 280W)  :-)

![Image of Yaktocat](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/solar_pv_energy/img/20190907_170414.jpg)
Vue des deux onduleurs (un par panneau) qui injectent le courant produit dans le réseau électrique 220V de la maison.

![Image of Yaktocat](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/solar_pv_energy/img/20190908_134444.jpg)
Petit transformateur de mesure du courant avec un rapport de 1/800 !

![Image of Yaktocat](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/solar_pv_energy/img/20190908_221514.jpg)
C'est mon NodeMCU de banc tests, il y a un pont diviseur pour faire une masse fictive à +0.5V qui permet de mesurer les alternances négatives du courant et la résistance *convertisseur* de courant de la mesure en tension (U=R*I).

![Image of Yaktocat](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/solar_pv_energy/img/20190908_213927.jpg)
n voit ici l'image du courant d'un foehn  (450W) en petite vitesse. On voit bien que la partie négative de l'alternance est effacée, c'est à cause de la mise ne série d'une diode avec le corps de chauffe, c'est un moyen très simple de diminuer le puissance dans un foehn

![Image of Yaktocat](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/solar_pv_energy/img/20190908_213900.jpg)
On voit ici l'image du courant d'un foehn (450W) en grande vitesse. L'alternance est bien complète ici. On voit aussi qu'elle se trouve dans la plage des 1V du convertisseur ADC du NodeMCU.


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

Dans ce projet il y a 1x NodeMCU qui mesure la production électrique de mon installation solaire PV. En en mesurant le courant (avec le petit transformateur de courant 1/800 connecté sur un fil) injecté dans le réseau électrique de ma maison des deux minis onduleurs qui convertissent la basse tension (36V) des panneaux PV en 220V du réseau électrique.
Le calcul de conversion tension/courant mesurée est très simpliste, un simple P=U*I*cos(phy). On ne tient pas du tout compte ici du cosinus phy qui pourrait varier en fonction des charges inductives dans la maison !



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

* **1**, production électrique des PV




**ATTENTION, readme pas encore terminé, il faut encore modifier le readme depuis ici ! zf190908.2222**

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


zf190908.2223


pense bête:

```
file.open("hello.lua","w+")
file.writeline([[print("hello nodemcu")]])
file.writeline([[print(node.heap())]])
file.close()
```
