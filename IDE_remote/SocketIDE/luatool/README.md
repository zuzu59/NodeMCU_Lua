# Remise au goût du jour le petit script luatool.py

## Sources
https://github.com/4refr0nt/luatool

## Description
Le petit script python *luatool.py* permet d'automatiser le téléchargement de
scripts *.lua* sur un NodeMCU branché sur le port USB.

## Problématiques
La version actuelle datant de 2017 ne fonctionne plus avec les nouveaux firmwares de NodeMCU, il a y un problème de délai au moment de l'initialisation

## Corrections
* J'ai donc repris le code python et mis un petit délai de 0.5 secondes juste après l'initialisation du port série.

* J'ai aussi diminué le délai d'attente entre chaque ligne, passé de 0.3 sec à 0.03. Les téléchargement sont donc 10x plus rapides

* J'ai aussi mis un nouveau telnet serveur qui tient compte des tailles maximales des paquets TCP



zf191020.1819
