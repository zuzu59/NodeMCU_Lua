# Mesure d'humidité et de température

Petit projet pour mesurer l'humidité et la température et l'afficher sur Grafana avec une DB InfluxDB. Comme par exemple pour monitorer l'humidité d'un local au cours du temps.

![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo/img/Constellation_sondes_mesures.jpg)

Constellation de sondes de mesures

![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo/img/htu21d_on_NodeMCU.jpg)

Montage du capteur HTU21D directement sur le NodeMCU, chose à ne PAS faire, car la température du NodeMCU fausse complètement les mesures d'humidité !

![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo/img/exemple_de_mesures_1.png)

Exemple de sortie sur Grafana


<br><br>
On peut voir ici, avec ce projet assez complet, toutes les possibilités offertes de la programmation d'un NodeMCU en LUA, en mode événementiel. <br>
Choses qui ne seraient pas possible si on l'avait fait en C++ (mode Arduino), comme par exemple:

* serveur WEB *Active Server Pages ZYX*, permet de faire des pages HTML dynamiques avec du code LUA in line. Les pages HTML sont sauvées dans le système de fichiers de la FLASH du NodeMCU
* serveur WEB pour l'affichage de l'humidité et de la température
* serveur WEB pour l'IDE, modification du code source en remote directement depuis une page WEB, pas besoin d'IDE
* crontab, horloge pour les mesures
* serveur TELNET, utilisation de la console en remote pour le dépannage

Toutes les fonctions sont bien séparées dans des scripts, cela *complexifie* le projet mais cela facilite la portabilité entre les projets et aussi sa mise au point.


## Astuces de mesures

On utilise un tout petit capteur, le **HTU21D**, d'humidité et de température I2C.

![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo/img/HTU21D.jpg)

Il est vraiment très bon marché (1.5$), simple à utiliser et super précis.

https://www.aliexpress.com/item/32480177429.html

![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo/img/super_definition_capteur_htu21d.jpg)

Incroyable la résolution de la mesure ! On peut observer ici l'arrivée le matin au salon, l'ouverture de la porte de la salle de bain après avoir pris la douche et l'ouverture de la fenêtre. Tout ceci dans la résolution de 1 à 3% de l'humidité relative

Présentation:

https://learn.sparkfun.com/tutorials/htu21d-humidity-sensor-hookup-guide/all

Datasheet:

https://cdn.sparkfun.com/assets/6/a/8/e/f/525778d4757b7f50398b4567.pdf


## Installation

Il faut *flasher* le NodeMCU avec ce firmware:

https://github.com/zuzu59/NodeMCU_Lua/blob/master/Firmware/nodemcu-master-18-modules-2019-12-17-20-28-32-float.bin

Avec ces modules:
```
adc,ads1115,bit,enduser_setup,file,gpio,http,i2c,net,node,ow,rtctime,si7021,sntp,spi,tmr,uart,wifi
 ```

## Utilisation

### Visualisation des données dans Grafana

Exemple de sortie dans Grafana

https://snapshot.raintank.io/dashboard/snapshot/LUqdTJYLNuC6WatmJoN21yQSEQ0UJ0oy


### Distribution des rôles de NodeMCU

Comme on peut avoir plusieurs points de mesures à différents endroit dans le local, il n'y a qu'un seul fichier de *secrets*. C'est dans ce fichier de *secrets* qu'il y a l'information de l'adresse IP de la base de donnée InfluxDB et c'est l'id des NodeMCU qui sont enregistrés dans la DB InfluxDB !<br>

```
secrets_projet.lua
```


### Exportation des données en CSV depuis Grafana

Quand on a trouvé la mesure qui nous convient sur Grafana, on peut l'exporter en CSV pour en faire un rapport dans un tableur par exemple.

![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo/img/exportation_data_csv.png)

![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo/img/coisir_series_as_columns.png)


### Affichage des températures/humidité en local sur le NodeMCU

On peut lire la température et l'humidité directement sur le NodeMCU au moyen de cette url (il faut modifier l'adresse IP du NodeMCU en question):

```
http://192.168.0.xxx/disp_temp.html
```


### Affichage du petit serveur web du NodeMCU_Lua

Chaque NodeMCU a son propre serveur WEB, on peut l'accéder simplement depuis son adresse IP:

```
http://192.168.0.xxx
```


### Modification du code source du NodeMCU en remote

Très pratique pour le debug, on peut directement modifier le code source Lua du NodeMCU en remote avec ce petit WEB IDE:

```
http://192.168.0.xxx:88
```


### Utilisation de la console du NodeMCU en remote

Très pratique pour le debug, on peut accéder à la console du NodeMCU en remote avec telnet:

```
telnet -rN 192.168.0.xxx
```



zf191219.1924


pense bête:

```
file.open("hello.lua","w+")
file.writeline([[print("hello nodemcu")]])
file.writeline([[print(node.heap())]])
file.close()
```
