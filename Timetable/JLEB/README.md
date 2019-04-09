# Affiche l'horaire du train Cheseaux à Lausanne sur un ruban de LED's RGB

zf190408.2100
## ATTENTION, cela ne fonctionne pas encore !

## Ce n'est pas encore automatique, il faut lancer à la main boot.lua et timetable.Lausanne

## Il y a un problème d'arrondi dans le calcul du nombre de 3 minutes, il ne faut pas arrondir 2mn31 à 3 minutes !<br>
Si c'est < 3 minutes il faut décompte moins un pour les clignotements car même pour 10 secondes on va rater le train !

## Il y a un très gros problème de raisonnement, car quand on se trouve entre -1 et 3 minutes du prochain train, l'horaire du train, que l'on va chercher sur Internet, ne va changer qu'une minute après le départ du train. Il faut donc prendre le prochain train indiqué et non le train actuel quand on se trouve à < 3 minutes du départ !

## A cause du problème de raisonnement, cela boucle en continu quand on se trouve entre -1 et 3 minutes du départ du train !
