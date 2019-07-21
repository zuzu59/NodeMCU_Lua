# Boîte à musique virtuelle

Joue simplement un son de boîte à musique pour faire croire que l'on a une boîte à musique ;-)


## NodeMCU

Utilise la fonction PCM du NodeMCU:

https://nodemcu.readthedocs.io/en/master/modules/pcm/



## Source audio

https://youtu.be/Fr2N-5V7aqQ


## Convertisseur Youtube en MP3

https://www.mp3hub.com

## Convertisseur MP3 en WAV pour pouvoir le jouer avec le NodeMCU

https://www.audacityteam.org/download/

Il faut convertir le MP3 en WAV raw 8 bits mono 1k ou 16k SpS

### Marche à suivre facile

* mettre 16000 tout en bas à gauche
* convertir en mono (Pistes/Piste stéréo vers mono)
* sélectionner avec la souris la partie à garder (cliquer sur le graphe !)
* exporter la sélection (Fichier/Exporter l'audio sélectionné)
* choisir autres formats non compressés puis btn option
* choisir WAV Microsoft unsigned 8 bits PCM
* enregistrer en effaçant les métas données !
* vérifier les informations avec le finder



zf190721.1233
