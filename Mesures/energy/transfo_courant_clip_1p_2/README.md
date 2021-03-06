# Mesure d'énergie d'une installation monophasée

Version pour l'installation solaire qui se trouve sur le sol !

zf200603.2016

**ATTENTION:<br>
Ce README est parti d'un autre projet similaire, donc pas tout juste pour ce projet**


<!-- TOC titleSize:2 tabSpaces:2 depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 skip:1 title:1 charForUnorderedList:* -->
## Table of Contents
* [Astuces de mesures de la puissance](#astuces-de-mesures-de-la-puissance)
  * [Schéma](#schéma)
  * [Astuces](#astuces)
* [Installation](#installation)
* [Utilisation](#utilisation)
  * [Distribution des rôles de NodeMCU](#distribution-des-rôles-de-nodemcu)
  * [Affichage des températures en local sur le NodeMCU](#affichage-des-températures-en-local-sur-le-nodemcu)
  * [Affichage du petit serveur web du NodeMCU_Lua](#affichage-du-petit-serveur-web-du-nodemculua)
  * [Modification du code source du NodeMCU en remote](#modification-du-code-source-du-nodemcu-en-remote)
  * [Utilisation de la console du NodeMCU en remote](#utilisation-de-la-console-du-nodemcu-en-remote)
* [Visualisation sur ThingSpeak](#visualisation-sur-thingspeak)
<!-- /TOC -->

Petit projet pour mesurer la puissance d'un appareil électrique à partir de la mesure du  courant avec un petit transformateur de courant qui se clips sur un conducteur avec un NodeMCU en LUA, et l'afficher sur Grafana avec une DB InfluxDB. Comme par exemple la production électrique d'une installation solaire photovoltaïque monophasée.

ATTENTION, dans ce projet, on ne tient pas compte du déphasage entre la tension et le courant (cos phy) !

![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/energy/transfo_courant_clip_1p/img/20190908_134444.jpg)
Petit transformateur de mesure du courant avec un rapport de 1/800 avec l'épissure pour la boucle de mesure de courant !

![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/energy/transfo_courant_clip_1p/img/20190908_221514.jpg)
C'est mon NodeMCU de banc tests, il y a un pont diviseur pour faire une masse fictive à +0.5V qui permet de mesurer les alternances négatives du courant et la résistance *convertisseur* de courant de la mesure en tension (U=R*I).

![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/energy/transfo_courant_clip_1p/img/20190908_213927.jpg)
On voit ici l'image du courant d'un foehn  (450W) en petite vitesse. On voit bien que la partie négative de l'alternance est effacée. C'est à cause de la mise ne série d'une diode avec le corps de chauffe du foehn, c'est un moyen très simple de diminuer le puissance.

![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/energy/transfo_courant_clip_1p/img/20190908_213900.jpg)
On voit ici l'image du courant d'un foehn (450W) en grande vitesse. L'alternance est bien complète ici. On voit aussi qu'elle se trouve dans la plage des 1V du convertisseur ADC du NodeMCU grâce à l'astuce de la *masse fictive* de 0.5V.

![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/energy/transfo_courant_clip_1p/img/20190907_170403.jpg)
Vue globale de mon installation solaire, pour l'instant posée sur le sol, de 2x panneaux de 280W  :-)

![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/energy/transfo_courant_clip_1p/img/20190907_170414.jpg)
Vue des deux onduleurs (un par panneau) qui injectent directement l'énergie produite dans le réseau électrique 220V de la maison.


<br><bR>
On peut voir ici, avec ce projet assez complet, toutes les possibilités offertes de la programmation des NodeMCU en LUA, en mode événementiel. <br>
Choses qui ne seraient pas possible si on l'avait fait en C++ (mode Arduino), comme par exemple:

* serveur WEB Active Server Pages ZYX, permet de faire des pages HTML dynamiques avec du code LUA in line. Les pages HTML sont sauve dans la FLASH du NodeMCU
* serveur WEB service pour le HUB concentrateur de mesures de différents NodeMCU (API GET)
* serveur WEB pour l'affichage de la consommation électrique
* serveur WEB pour l'IDE, modification du code source en remote directement depuis une page WEB, pas besoin d'IDE
* crontab, horloge pour les mesures
* serveur TELNET, utilisation de la console en remote pour le dépannage

Toutes les fonctions sont bien séparées dans des scripts, cela *complexifie* le projet mais ce qui facilite la portabilité entre les projets et aussi sa mise au point.



## Astuces de mesures de la puissance

Dans ce projet il y a 1x NodeMCU qui mesure la production électrique de mon installation solaire PV. On mesure le courant injecté dans le réseau électrique de la maison avec un petit transformateur de courant *clipsé* sur la phase du smart inverter.<br>

### Schéma

![Image](https://github.com/zuzu59/NodeMCU_Lua/blob/master/Mesures/energy/transfo_courant_clip_1p/schemas/sch%C3%A9ma.png?raw=true)

Le petit transfo de courant a un rapport de 25mA à 20A, soit 0.025/20=0.00125 soit encore 1/800.

Une masse virtuelle de 0.5V est constituée avec le pont des résistances R2/R1, cela permet de *remonter* la tension alternative de la mesure de courant.

La résistance R3 est utilisée pour la conversion courant/tension du transfo de courant.<br>
Pour une charge maximale de 600W, la résistance R3 est de 100R, et pour 1'200W elle est de 56R.

### Astuces

* Comme le convertisseur ADC du NodeMCU ne peut mesurer que des valeurs positives comprises entre 0V et 1V, on ajoute une masse *fictive* au signal du transformateur de courant de 0.5V afin de *remonter* l'alternance négative.<br>
Au lieu de *découper* la sinusoïde (50Hz) en 100 *parties*, c'est à dire toutes les 0.2ms (5'000x /s), pour en faire l'intégrale. On lit l'ADC toutes les 11ms (seulement 91x /s) donc beaucoup plus lentement.<br>
* Comme la sinusoïde fait 20ms et est *répétitive*, on balaye (par *décalage*) statistiquement la sinusoïde.<br>
* On *redresse* l'alternance par rapport à la masse fictive (env 0.5V), ce qui nous permet d'estimer une valeur RMS du courant quelque soit sa forme et on la moyenne sur une période de 2.1 secondes.<br>
* Les mesures min et max ne sont là juste que pour vérifier que nous sommes bien dans la plage de mesure avec le choix de la résistance de *conversion* du transformateur de courant.<br>
* Le calcul de la puissance mesurée est très simpliste, un simple ```P=U*I```. On ne tient donc pas compte ici du ```cos(phy)``` qui pourrait varier en fonction des charges inductives dans la maison !



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

Comme la mesure de production électrique est faite avec 1x NodeMCU, il y a donc 1x fichier de *secrets*. C'est dans ce fichier de *secrets* qu'il y a l'information de l'adresse IP de la base de donnée InfluxDB !<br>

```
secrets_energy.lua
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




pense bête:

```
file.open("hello.lua","w+")
file.writeline([[print("hello nodemcu")]])
file.writeline([[print(node.heap())]])
file.close()
```
