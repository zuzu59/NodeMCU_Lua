# Tests et découverte du petit breakout ADS1115, convertisseur analogique digital 16 bits 4x entrées

Petit projet pour tester et découvrir cd petit bijou qu'est le breakout ADS1115, convertisseur analogique digital 16 bits 4x entrées utilisable en I2C.

<br><br>![Image](https://zraw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo-thingspeak/img/graph_thingspeak1.png)

Module ADS1115



## Autres utilisations de ce projet

On peut très bien *enregistrer* d'autres *mesures* comme par exemple, une consommation électrique, production solaire ou débit d'eau d'une douche. Il y a très peu de lignes à modifier pour le faire. C'est donc la base de l'enregistrement pour pleins de mesures en domotique ;-)



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

On utilise un tout petit capteur low cost, le **xxx**, mesure de xxx sur bus I2C.

<br><br>![Image](https://zraw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo-thingspeak/img/graph_thingspeak1.png)

Module ADS1115

<br><br>![Image](https://zraw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo-thingspeak/img/graph_thingspeak1.png)

Broches ADS1115

Qui ne coûte que 1.5$

https://www.aliexpress.com/item/32850495005.html


Présentation:

https://learn.adafruit.com/adafruit-4-channel-adc-breakouts/downloads

Datasheet:

https://cdn-shop.adafruit.com/datasheets/ads1115.pdf


### Schéma

<br><br>![Image](https://zraw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo-thingspeak/schema/schema.png)

Schéma de connexion à 4x fils très simple


<br><br>![Image](https://zraw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo-thingspeak/schema/pcb.png)

Et son PCB (breadboard)


<br><br>![Image](https://zraw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo-thingspeak/img/banc_test_HTU21D.jpg)

Banc test de Mesures





# ATTENTION: le reste de ce README n'est pas tout à fait juste, il a été emprunté provisoirement à un autre projet !   zf200126.1124







## Parties principales du code
Le corps du projet se trouve dans ces 4x fichiers !

* secrets_project.lua
* 0_htu21d.lua
* 0_send_data.lua
* 0_cron.lua


### Les secrets du projet

Dans ce fichier se trouvent les *secrets* du projet qui ne doivent pas se retrouver sur GitHub, mais qui peuvent aussi être différents si on *duplique* son projet dans différents *lieux* (mesure à Lausanne et Renens par exemple).

```
if node.chipid() == 6734851 then node_id = "sonoff_1" zLED=7 end
if node.chipid() == 16110605 then node_id = "sonoff_2" zLED=7 end
if node.chipid() == 3049119 then node_id = "adc_1" end
if node.chipid() == 3048906 then
    node_id = "bolo_1"
    thingspeak_url="http://api.thingspeak.com/update?api_key=kkk&"
end
if node.chipid() == 3049014 then
    node_id = "tst_temp_1"
    thingspeak_url="http://api.thingspeak.com/update?api_key=kkk&"
end
```

C'est ici que l'on met l'*url* avec son *token* utilisé par *ThingSpeak*
ThingSpeak

On met aussi ici l'*identification* du NodeMCU de la mesure afin de pouvoir reconnaitre les différents *points* de mesure dans un même lieu. Chaque NodeMCU à son *propre* numéro de *série* !


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

Lors du démarrage du NodeMCU il va chercher à se connecter sur le WIFI qu'il trouve dans sa configuration, fichier *eus_params.lua*. S'il n'y parvient pas au bout de 15 secondes, il va démarrer un petit serveur WIFI, **AP: NodeMCU_node_id**, on peut alors utiliser le NodeMCU sans avoir besoin d'une *connexion* Internet, mais bien entendu sans envoi de données dans le Cloud.

On se connecte alors avec un browser WEB sur l'adresse:

```
http://192.168.4.1
```

On choisit *Wifi setup* et enfin, au milieu de la page, on confirme l'action en cliquant sur *Ok* (ceci pour éviter que l'on bascule dans le mode setup WIFI par erreur).

Après quelques secondes un nouveau serveur WIFI va démarrer avec une procédure de configuration du WIFI du NodeMCU, **AP: Setup Gadget** xxx, on se connecte dessus avec son ordinateur pour aller à nouveau *voir* la page:

```
http://192.168.4.1
```

Après configuration du WIFI, l'adresse IP allouée au NodeMCU devrait apparaître en haut de la page.

Le NodeMCU redémarre et est prêt à envoyer les mesures sur le Cloud, s'il est configuré correctement pour le bon compte ThingSpeak !



### Configuration de ThingSpeak

Afin de pouvoir utiliser ThingSpeak, il faut *créé* un *channel*, le configurer pour lui indiquer que nous voulons deux champs (température et humidité) et surtout récupérer le token du channel pour le mettre dans le fichier *secrets_projet.lua*



### Visualisation des données dans ThingSpeak

On peut voir alors arriver, toutes les 20 secondes, les mesures de température et d'humidité sur ThingSpeak.

<br><br>![Image](https://raw.githubusercontent.com/zuzu59/NodeMCU_Lua/master/Mesures/humidity/bolo-thingspeak/img/graph_thingspeak1.png)
Exemple de sortie sur ThingSpeak

On peut facilement modifier l'affichage des graphiques au moyen du petit *crayon* en haut à droite de chaque graphique

Très vite on va s'apercevoir qu'il faudra augmenter le temps entre chaque mesures, passer à 300 secondes au lieu de 20 secondes par exemple.



### Exportation des données en CSV depuis ThingSpeak

On peut très facilement exporter après coup les données du channel de ThingSpeak en CSV pour en faire un rapport dans un tableur par exemple.



### Distribution des rôles de NodeMCU

Comme on peut avoir plusieurs points de mesures à différents endroit dans le local, il n'y a qu'un seul fichier de *secrets*. C'est dans ce fichier, *secrets_projet.lua*, qu'il y a l'information de l'url de ThingSpeak ains que le token pour le bon channel !<br>



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

On peut directement modifier le code source Lua du NodeMCU en remote avec ce petit WEB IDE (il faut le *lancer* avant depuis la home page du NodeMCU !):

```
http://192.168.0.xxx:88
```


### Utilisation de la console du NodeMCU en remote

Très pratique pour le debug, on peut accéder à la console du NodeMCU en remote avec telnet:

```
telnet -r 192.168.0.xxx
```

ou sur MAC

```
telnet -rN 192.168.0.xxx
```

C'est aussi depuis ce moyen que l'on peut mettre, à distance, à jour le code Lua du NodeMCU de manière centralisée et automatique (luatool.py)




zf200126.1127
