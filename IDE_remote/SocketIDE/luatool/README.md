# Remise au goût du jour le petit script luatool.py

## Sources
https://github.com/4refr0nt/luatool


## Description
Le petit script python *luatool.py* permet d'automatiser le téléchargement de
scripts *.lua* sur un NodeMCU branché sur le port USB.<br>
Mais il permet aussi et surtout de le faire via WIFI. Pour cela il faut que le petit serveur *telnet* tourne sur le NodeMCU !


## Problématiques
La version actuelle datant de juillet 2017 ne fonctionne plus avec les nouveaux firmwares de NodeMCU. Il a y un problème au moment de l'initialisation de la connexion série.


## Travail effectué
* J'ai donc repris le code python et mis un petit délai de 0.5 secondes juste après l'initialisation du port série.

* J'ai aussi diminué le délai d'attente entre chaque ligne, passé de 0.3 sec à 0.03 sec. Les téléchargements sont donc 10x plus rapides

* J'ai aussi mis un nouveau telnet serveur qui tient compte des tailles maximales des paquets TCP

* J'ai aussi bien amélioré le script luatool.py (voir le code source)


## Installation
Maintenant c'est très facile de télécharger tout un projet sur un NodeMCU. Il suffit simplement de modifier le petit script bash upload.sh, puis de faire:

```
./upload.sh
```
* S'il y a des erreurs lors d'un téléchargement, il faut simplement augmenter un peu le délai !<br>
* Il est préférable de télécharger en premier les *gros* fichiers .lua !


## Test via WIFI en telnet
Après avoir installé tout le *binz* sur le NodeMCU avec le script *upload.sh*, on peut utiliser *luatool.py* via le WIFI.<br>
On peut le tester avec le petit script:
```
./test_toto-sh
```

* Si cela fonctionne, la LED devrait arrêter de clignoter ;-)


## Goodies
### Quelques commandes en WIFI ;-)
**ATTENTION:** ces exemples de commandes sont pour MON adresse IP actuelle de mon NodeMCU ;-)

Help du luatool.py
```
./luatool.py -h
```

Liste les fichiers qui se trouvent sur le NodeMCU
```
./luatool.py --ip 192.168.0.157 -l
```

Télécharge le fichier *toto.lua* sur le NodeMCU
```
./luatool.py --ip 192.168.0.157 -f toto.lua
```

Télécharge le fichier *toto.lua* sur le NodeMCU, mais le renomme en *tutu.lua* et affiche une *progression bar* de l'évolution du téléchargement
```
./luatool.py --ip 192.168.0.157 -f toto.lua -t tutu.lua
```

Vérifie que tout est bon sur le NodeMCU
```
./luatool.py --ip 192.168.0.157 -l
```

Efface le fichier *toto.lua* sur le NodeMCU
```
./luatool.py --ip 192.168.0.157 --delete toto.lua
```

Efface le fichier *tutu.lua* sur le NodeMCU
```
./luatool.py --ip 192.168.0.157 --delete tutu.lua
```

Vérifie que tout est bon sur le NodeMCU
```
./luatool.py --ip 192.168.0.157 -l
```


zf191020.2127
