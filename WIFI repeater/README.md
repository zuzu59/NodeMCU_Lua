# WIFI repeater, tout petit répéteur WIFI à base de NodeMCU ESP
zf200814.2235

<!-- TOC titleSize:2 tabSpaces:4 depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 skip:1 title:1 charForUnorderedList:* -->
## Table of Contents
* [Sources](#sources)
* [Description](#description)
* [Problématiques](#problématiques)
* [Installation, flashing du firmware](#installation-flashing-du-firmware)
* [Utilisation](#utilisation)
    * [Utilisation de la console](#utilisation-de-la-console)
    * [Via le port série](#via-le-port-série)
    * [Via telnet](#via-telnet)
    * [Verrouillage du repeater](#verrouillage-du-repeater)
    * [Changer les paramètres WIFI en console](#changer-les-paramètres-wifi-en-console)
    * [Configuration du NAT](#configuration-du-nat)
* [Reset factory](#reset-factory)
* [Limitations](#limitations)
* [Goodies](#goodies)
    * [Eteindre la LED de status du NodeMCU](#eteindre-la-led-de-status-du-nodemcu)
* [Documentation complète](#documentation-complète)
<!-- /TOC -->


## Sources
https://github.com/martin-ger/esp_wifi_repeater


## Description
WIFI repeater est un petit répéteur WIFI à base de NodeMCU ESP vraiment génial. C'est incroyable ce que l'on arrive à faire dans un si petit hardware.
Il peut même tourner dans des ESP minuscule comme la série ESP-0x.

Très pratique pour étendre la portée d'un réseau WIFI, il y a aussi le mode ** qui permet de créer des cellules ainsi qu'un *firewall*.


## Problématiques
Malheureusement cela ne tourne pas en Lua, mais ce n'est pas grave dans ce cas précis où on utilise une pièce logicielle commune.

On peut le compiler soit même, mais c'est beaucoup plus simple de simplement flasher le firmware proposer avec l'utilitaire esptool


## Installation, flashing du firmware
Le plus simple est d'utiliser l'utilitaire fourni par ESP, esptool.

Les binaires se trouvent sur:

https://github.com/martin-ger/esp_wifi_repeater/tree/master/firmware

Commande pour le flashing:

If you want to use the complete precompiled firmware binaries you can flash them with
```
esptool.py --port /dev/ttyUSB0 write_flash -fs 4MB -ff 80m -fm dio 0x00000 firmware/0x00000.bin 0x02000 firmware/0x02000.bin
```
(use -fs 1MB for an ESP-01). For the esp8285 you must use -fs 1MB and -fm dout.

Script pour flasher le NodeMCU plus facilement:

```
./zflash.sh go
```

## Utilisation
Pour la première configuration il faut se connecter sur l'AP *MyAP* et charger la page **192.168.4.1** pour la configuration du WIFI *repeater*.


### Utilisation de la console
On peut accéder à la console soit via le port série ou telnet. Après connexion demandez le help avec la commande help !


### Via le port série
```
screen /dev/cu.wchusbserial1410 115200
screen /dev/cu.usbserial-14422310 115200
```


### Via telnet
```
telnet -rN 192.168.4.1 7777
```


### Verrouillage du repeater
<b>ATTENTION !

SI VOUS UTILISEZ CE WIFI REPEATER POUR FAIRE UNE ZONE DMZ POUR ISOLER UN DEVICE, IL NE FAUT PAS OUBLIER DE BLOQUER LA CONFIGURATION VIA L'INTERFACE WEB OU LA CONSOLE TELNET</b>

Des fois on aimerait bien qu'il ne soit pas possible de modifier la configuration du repeater via le WEB ou depuis la console telnet. Il suffit alors de faire depuis la console série:
```
set config_port 0
set web_port 0
set config_access 0
save
```

ATTENTION: à ne pas oublier de faire un *save* à la fin !


### Changer les paramètres WIFI en console
Configurer le router WIFI de la maison à répéter avec le repeater
```
set ssid <votre routeur WIFI de la maison>
```
Configurer le password pour se connecter à votre routeur WIFI de la maison
```
set password <le password de votre routeur wifi de la maison>
```
Configurer le nom WIFI de votre repeater
```
set ap_ssid <le nom WIFI de votre repeater>
```
Configurer le password WIFI de votre repeater
```
set ap_password <le password WIFI de votre repeater>
```
Sauvegarder votre configuration
```
save config
```
Redémarrer votre repeater
```
reset
```

### Configuration du NAT
On peut configurer très facilement le NAT avec la commande *portmap*:<br>
Ouvrir le port 22 de la machine 192.168.4.2 sur le port 2222 du routeur
```
portmap add TCP 2222 192.168.4.2 22
```
On peut voir après la configuration en faisant un:
```
show config
```
Fermeture du port 2222
```
portmap remove TCP 2222
```
ATTENTION: il ne faut pas oublier de sauver la configuration !
```
save config
```
Comme les adresses IP sont attribuées dynamiquement, il serait bien de sauvegarder après aussi le DHCP, afin que la même adresse IP soit attribuée à la même machine !
```
save dhcp
```


## Reset factory
Il faut se connecter en série sur la console et entrer la commande:
```
reset factory
```


## Limitations
* A cause du SDK de ESP (AP software), l'AP WIFI est limité à 8 connexions simultanées.

* Les performances ne sont vraiment pas gigantesques, 100x moins vite ! En moyenne 0.3Mbits/s en réception et 0.8Mbits en émission, mais c'est amplement suffisant pour de la domotique et télémesure

https://speedtest.cnlab.ch/fr/

https://fast.com/fr/


## Goodies
### Eteindre la LED de status du NodeMCU
Simplement faire:
```
set status_led 255
```
Pour la réactiver il faut faire:
```
set status_led 2
```

ATTENTION: il ne faut pas oublier de sauver la config avec:
```
save config
```

## Documentation complète
https://github.com/martin-ger/esp_wifi_repeater/blob/master/README.md

