# Mesure de température et d'humidité

Petit projet pour mesurer la température et l'humidité avec un capteur HTU21D et l'afficher sur ThingSpeak. Comme par exemple pour monitorer la température et l'humidité d'un local au cours du temps.

<br><br>![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo-thingspeak/img/graph_thingspeak1.png)

Exemple de sortie sur ThingSpeak


<br><br>![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo-thingspeak/img/Constellation_sondes_mesures2.jpg)

Constellation de sondes de mesures


<br><br>![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo-thingspeak/img/htu21d_on_NodeMCU.jpg)

Montage du capteur HTU21D directement sur le NodeMCU, chose à ne PAS faire, car la température du NodeMCU fausse complètement les mesures d'humidité !


<br><br>![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo-thingspeak/img/HTU21D_deporte.jpg)

Montage correct du capteur HTU21D en *déporté* sur le NodeMCU


<br><br>
## Avantages de travailler avec langage interprété (Lua) VS compilé (Arduino C++)

On peut voir ici, avec ce projet assez complet, toutes les possibilités offertes de la programmation d'un NodeMCU en LUA, en mode événementiel. <br>
Choses qui ne seraient pas possible si on l'avait fait en C++ (mode Arduino), comme par exemple:

* configuration du WIFI via une page WEB servie par le NodeMCU (pas besoin de brancher un interface USB/TTL)
* serveur WEB *Active Server Pages ZYX*, permet de faire des pages HTML *dynamiques* avec du code LUA *in line*. Les pages HTML sont *sauvées* dans le système de fichiers de la FLASH du NodeMCU et *interprétées au vol* lors de la *lecture*
* serveur WEB pour l'affichage de l'humidité et de la température
* mini WEB IDE, modification du code source en remote directement depuis une page WEB, pas besoin d'IDE
* serveur TELNET, utilisation de la console en remote pour le dépannage (mise à jour du code centralisée)
* crontab, horloge pour les mesures

Toutes les fonctions sont bien séparées dans des scripts .lua, cela *complexifie* le projet mais cela facilite la portabilité entre les projets et aussi sa mise au point.


## Principes de mesures

On utilise un tout petit capteur low cost, le **HTU21D**, mesure de température et d'humidité sur bus I2C.

https://www.aliexpress.com/item/32480177429.html


<br><br>![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo-thingspeak/img/HTU21D.jpg)

Il est vraiment très bon marché (1.5$), simple à utiliser et super précis.


<br><br>![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo-thingspeak/img/super_definition_capteur_htu21d.jpg)

Incroyable la résolution de la mesure ! On peut observer ici l'arrivée le matin au salon, l'ouverture de la porte de la salle de bain après avoir pris la douche et l'ouverture de la fenêtre. Tout ceci dans la résolution de 1 à 3% de l'humidité relative


Présentation:

https://learn.sparkfun.com/tutorials/htu21d-humidity-sensor-hookup-guide/all


Datasheet:

https://cdn.sparkfun.com/assets/6/a/8/e/f/525778d4757b7f50398b4567.pdf


### Schéma

<br><br>![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo-thingspeak/schema/schema.png)

Schéma de connexion à 4x fils très simple


<br><br>![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo-thingspeak/schema/pcb.png)

Et son bread board


<br><br>![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo-thingspeak/img/banc_test_HTU21D.jpg)

Banc test de Mesures


## Le cloud ThingSpeak

ThingSpeak est un service de plateforme d'analyse IoT qui vous permet d'agréger, de visualiser et d'analyser des flux de données en direct dans le cloud. Vous pouvez envoyer des données à ThingSpeak depuis vos appareils, créer une visualisation instantanée des données en direct et envoyer des alertes.

La version gratuite nous permet de faire:

* envoi de 3'000'000 de message par an, soit environ 8'200 messages par jour
* intervalle d'envoi entre deux messages est d'au minimum de 15 secondes
* 4x canaux à disposition
* 3x connexion simultanées au MQTT
* 3x partages de canaux privés

Ce qui est amplement suffisant pour débuter avec l'IoT dans le Cloud et savoir ce que l'on veut faire par la suite ;-)

La version payante est assez chère, comme toutes les autres du reste :-(


## Parties principales du code
Le corps du projet se trouve dans ces 4x fichiers !

* secrets_project.lua
* 0_htu21d.lua
* 0_send_data.lua
* 0_cron.lua


### Les secrets du projet

Dans ce fichier se trouvent les *secrets* du projet qui ne doivent pas se retrouver sur GitHub, mais qui peuvent aussi être différents si on *duplique* son projet dans différents *lieux* (mesure à Lausanne et Renens par exemple).

```
thingspeak_url="http://api.thingspeak.com/update?api_key=xxx"

node_id = "generic"
if node.chipid() == 6734851 then node_id = "sonoff_1" zLED=7 end
if node.chipid() == 16110605 then node_id = "sonoff_2" zLED=7 end
if node.chipid() == 3049119 then node_id = "adc_1" end
if node.chipid() == 3048906 then node_id = "bolo_1" end
print("node_id: "..node_id)
end
```

C'est ici que l'on met l'*url* avec son *token* utilisé par *ThingSpeak*
ThingSpeak

On met aussi ici l'*identification* du NodeMCU de la mesure afin de pouvoir reconnaitre les différents *points* de mesure dans le même lieu. Chaque NodeMCU à son propre numéro de *série* !


### La mesure de température et d'humidité

On accède au capteur de mesure de température et d'humidité HTU21D très simplement (pas besoin de lib) au moyen de commandes de base I2C:

i2c.start, i2c.stop, i2c.address, i2c.write, i2c.read

```
function read_HTU21D(zreg, zdelay)
    i2c.start(id)   i2c.address(id, addr, i2c.TRANSMITTER)
    i2c.write(id, zreg)   i2c.stop(id)
    i2c.start(id)   i2c.address(id, addr, i2c.RECEIVER)
    tmr.delay(zdelay)
    r = i2c.read(id,3)   i2c.stop(id)
    return r
end
```


### L'envoi des mesures dans le Cloud ThingSpeak

Les données de mesures sont simplement envoyées sur ThingSpeak au moyen d'une *requête* HTML de type *GET*:

On peut le faire directement depuis son browser pour des tests par exemple: envoi des valeurs température de 12˚ et humidité 45%:

```
https://api.thingspeak.com/update?api_key=kkk&field1=12&field1=45
```

Construction de l'url d'envoi en Lua:

```
zurl=thingspeak_url.."field1="..tostring(ztemp1).."&field2="..tostring(zhum1)
send_temp()
```


### L'horloge des mesures

Finalement il faut *envoyer* au moyen d'un *timer* toutes les x secondes les mesures de températures au Cloud ThingSpeak

```
cron1=tmr.create()
cron1:alarm(20*1000,  tmr.ALARM_AUTO, function()
    print("cron1........................")
    ztemp1=readTemp()
    zhum1=readHumi()
    print("Temperature: "..ztemp1.." °C")
    print("Humidity: "..zhum1.." %")
    zurl=thingspeak_url.."field1="..tostring(ztemp1).."&field2="..tostring(zhum1)
    send_temp()
end)
```



## Installation

Il faut *flasher* le NodeMCU avec ce firmware:

https://github.com/zuzu59/NodeMCU_Lua/blob/master/Firmware/nodemcu-master-19-modules-2019-12-31-16-40-12-float.bin

Qui contient ces modules:
```
adc ads1115 bit enduser_setup file gpio http i2c mqtt net node ow rtctime sjson sntp tmr uart wifi ws2812
```

C'est un firmware passe partout, il contient trop de modules pour ce projet mais qui est très pratique !



## Utilisation


### Configuration du WIFI du NodeMCU_Lua
L'accès au NodeMCU se fait via des pages WEB distribuée depuis son petit serveur WEB ASP (Active Server Pages) avec l'interprétation du code Lua inline au vol !


c'est pas terminé !

xxx



### Configuration de ThingSpeak

token !



### Visualisation des données dans ThingSpeak
<br><br>![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo-thingspeak/img/graph_thingspeak1.png)
Exemple de sortie sur ThingSpeak


### Distribution des rôles de NodeMCU

Comme on peut avoir plusieurs points de mesures à différents endroit dans le local, il n'y a qu'un seul fichier de *secrets*. C'est dans ce fichier de *secrets* qu'il y a l'information de l'adresse IP de la base de donnée InfluxDB et c'est l'id des NodeMCU qui sont enregistrés dans la DB InfluxDB !<br>

```
secrets_projet.lua
```


### Exportation des données en CSV depuis ThingSpeak

zzz, on peut l'exporter xxx en CSV pour en faire un rapport dans un tableur par exemple.

<br><br>![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo-thingspeak/img/exportation_data_csv.png)

<br><br>![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo-thingspeak/img/coisir_series_as_columns.png)


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



zf200118.1237


pense bête:

```
file.open("hello.lua","w+")
file.writeline([[print("hello nodemcu")]])
file.writeline([[print(node.heap())]])
file.close()
```
