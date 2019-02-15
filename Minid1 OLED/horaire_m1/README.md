# Affichage sur écran mini OLED le prochain départ du métro M1
zf190213.0924

## Buts
Afficher sur un mini OLED l'heure de départ du prochain métro M1 pour une station donnée

## Moyens
Le NodeMCU fait une requête client WEB sur l'API des TL et l'affiche sur l'écran mini OLED



## Sources

https://www.t-l.ch/particuliers/se-deplacer/horaires/horaires-en-ligne

http://transport.opendata.ch/v1/connections?from=EPFL&to=Renens-Gare&fields[]=connections/from/departure

https://timetable.search.ch/api/help

https://www.viadi-mobility-services.ch/routing-service/

