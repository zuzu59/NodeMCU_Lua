# Le WEB IDE de Matthieu Borgognon

## Sources
Il a modifié le WEB_IDE de https://github.com/joysfera/nodemcu-web-ide afin de lui ajouter la commande 'rename'

Son fichier tenu à jour se trouve dans son dépôt ici:

https://github.com/matbgn/NodeMCU/tree/master/lib/web-ide

Mais, j'en ai fait une petite copie locale pour pouvoir bosser dessus ;-)

## Changes
* ajouté le header de version ;-)
* refactorisé les timers utilisés
* ajouté l'utilisation de UTF-8

## Problématique
Ce WEB IDE consomme BEAUCOUP trop de RAM par rapport à *mon* WEB IDE (**web_ide2.lua**) !

web_ide_MB.lua **22'784**<br>
web_ide2.lua **3'1128**

diff 31128-22784= **8'344** de plus !

Ce n'est donc pas possible de l'utiliser en l'état :-(






zf191020.1333
