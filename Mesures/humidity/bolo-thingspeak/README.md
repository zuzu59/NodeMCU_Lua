# Mesure de température et d'humidité

Petit projet pour mesurer la température et l'humidité avec un capteur HTU21D et l'afficher sur ThingSpeak. Comme par exemple pour monitorer la température et l'humidité d'un local au cours du temps.


![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo-thingspeak/img/graph_thingspeak1.png)

Exemple de sortie sur ThingSpeak


![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo-thingspeak/img/Constellation_sondes_mesures2.jpg)

Constellation de sondes de mesures


![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo-thingspeak/img/htu21d_on_NodeMCU.jpg)

Montage du capteur HTU21D directement sur le NodeMCU, chose à ne PAS faire, car la température du NodeMCU fausse complètement les mesures d'humidité !


<br><br>
## Avantages de travailler avec langage interprété (Lua) VS compilé (Arduino C++)

On peut voir ici, avec ce projet assez complet, toutes les possibilités offertes de la programmation d'un NodeMCU en LUA, en mode événementiel. <br>
Choses qui ne seraient pas possible si on l'avait fait en C++ (mode Arduino), comme par exemple:

* configuration du WIFI via une page WEB servie par le NodeMCU (pas besoin de brancher un interface USB/TTL)
* serveur WEB *Active Server Pages ZYX*, permet de faire des pages HTML dynamiques avec du code LUA in line. Les pages HTML sont sauvées dans le système de fichiers de la FLASH du NodeMCU et interprétées au vol lors de la lecture
* serveur WEB pour l'affichage de l'humidité et de la température
* mini WEB IDE, modification du code source en remote directement depuis une page WEB, pas besoin d'IDE
* serveur TELNET, utilisation de la console en remote pour le dépannage (mise à jour du code centralisée)
* crontab, horloge pour les mesures

Toutes les fonctions sont bien séparées dans des scripts .lua, cela *complexifie* le projet mais cela facilite la portabilité entre les projets et aussi sa mise au point.


## Principes de mesures

On utilise un tout petit capteur low cost, le **HTU21D**, mesure de température et d'humidité sur bus I2C.

https://www.aliexpress.com/item/32480177429.html


![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo-thingspeak/img/HTU21D.jpg)

Il est vraiment très bon marché (1.5$), simple à utiliser et super précis.


![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo-thingspeak/img/super_definition_capteur_htu21d.jpg)

Incroyable la résolution de la mesure ! On peut observer ici l'arrivée le matin au salon, l'ouverture de la porte de la salle de bain après avoir pris la douche et l'ouverture de la fenêtre. Tout ceci dans la résolution de 1 à 3% de l'humidité relative


Présentation:

https://learn.sparkfun.com/tutorials/htu21d-humidity-sensor-hookup-guide/all


Datasheet:

https://cdn.sparkfun.com/assets/6/a/8/e/f/525778d4757b7f50398b4567.pdf


### Schéma

![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo-thingspeak/schema/schema.jpg)

Schéma de connexion à 4x fils très simple


![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo-thingspeak/schema/schema.jpg)

Et son bread board


![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo-thingspeak/img/banc_test_HTU21D.jpg)

Banc test de Mesures


## Le cloud ThingSpeak

bla bla bla


Les conditions du gratuit





## Parties principales du code
Tout se passe dans ces 4x fichiers !

### Les secrets du projet

ThingSpeak

token !


chip id




### La mesure de température et d'humidité





### L'envoi des mesures dans le Cloud ThingSpeak





### L'horloge des mesures







## Installation

Il faut *flasher* le NodeMCU avec ce firmware:

https://github.com/zuzu59/NodeMCU_Lua/blob/master/Firmware/nodemcu-master-19-modules-2019-12-31-16-40-12-float.bin

Avec ces modules:
```
adc ads1115 bit enduser_setup file gpio http i2c mqtt net node ow rtctime sjson sntp tmr uart wifi ws2812
```

## Utilisation


### Configuration du WIFI du NodeMCU_Lua

xxx



### Configuration de ThingSpeak

token !



### Visualisation des données dans ThingSpeak
![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo-thingspeak/img/graph_thingspeak1.png)
Exemple de sortie sur ThingSpeak


### Distribution des rôles de NodeMCU

Comme on peut avoir plusieurs points de mesures à différents endroit dans le local, il n'y a qu'un seul fichier de *secrets*. C'est dans ce fichier de *secrets* qu'il y a l'information de l'adresse IP de la base de donnée InfluxDB et c'est l'id des NodeMCU qui sont enregistrés dans la DB InfluxDB !<br>

```
secrets_projet.lua
```


### Exportation des données en CSV depuis ThingSpeak

zzz, on peut l'exporter xxx en CSV pour en faire un rapport dans un tableur par exemple.

![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo-thingspeak/img/exportation_data_csv.png)

![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo-thingspeak/img/coisir_series_as_columns.png)


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



zf200116.1902


pense bête:

```
file.open("hello.lua","w+")
file.writeline([[print("hello nodemcu")]])
file.writeline([[print(node.heap())]])
file.close()
```
