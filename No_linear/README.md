# Correction d'un capteur non linéaire au moyen d'une table de conversion

## Astuce de ce script


Comme le capteur n'est lu qu'à la demande, c'est à dire pas trop vite et souvent, j'ai mis la table d'interpolation dans un fichier .csv sur la flash et je l'a lis au vol pour chercher les deux valeurs proches de la mesure. Après je n'ai plus qu'à faire l'interpolation des deux valeurs proches en considérant que c'est une petite droite.

Ainsi on économise fortement l'utilisation de la RAM :-)








zf190422.0956
