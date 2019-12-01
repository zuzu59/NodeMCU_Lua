# WIFI repeater, tout petit répéteur WIFI à base de NodeMCU ESP

## Sources



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

## utilisation
Pour la première configuration il faut se connecter sur l'AP *MyAP* et charger la page **192.168.4.1** pour la configuration du WIFI *repeater*.


## Utilisation de la console
On peut accéder à la console soit via le port série ou telnet. Après connexion demandez le help avec la commande help !

### Via le port série

```
screen /dev/cu.wchusbserial1410 115200
```

### Via telnet
```
telnet -rN 192.168.4.1 7777
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


## Documentation complète
https://github.com/martin-ger/esp_wifi_repeater/blob/master/README.md



zf191201.1317
