# Correction d'un capteur non linéaire au moyen d'une table de conversion

## Astuce de ce script

Comme on ne lit le capteur qu'à la demande, il n'est pas nécessaire de garder la table de conversion en RAM en permanence. Afin d'économiser fortement la RAM, les valeurs de conversion se trouvent dans un fichier .csv sur la flash et est lu à chaque fois à la volée.

Une interpolation linéaire est faite entre les deux valeurs proches dans la table.





zf190421.2232
