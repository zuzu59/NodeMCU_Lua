# Zyx, le Pico framework Active Server Pages avec Lua inline
zf190127.1733

## Problématique
Le microcontrôleur NodeMCU à base de ESP8266 est une superbe petite bête. Il possède directement un interface WIFI avec une couche TCP complète et de plus se programme très facilement en Lua script.
Du coup il est le candidat idéal pour l'internet des objets (IoT), et de lui programmer un petit interface WEB est une chose très facile:

```
srv = net.createServer(net.TCP)
srv:listen(80, function(conn)
    conn:on("receive", function(client, request)
        print(request)
        client:send("<h1> ESP8266<br>Server is working!</h1>"..tmr.now())
    end)
    conn:on("sent", function(c) c:close() end)
end)
```

Par contre on doit *produire* le code HTML directement depuis le code LUA et on voit bien que cela devient vite très pénible pour la moindre page HTML un tant soit peu évoluée.
C'est aussi l'enfer de répondre à plusieurs pages HTML.
Oui, on sait bien que l'on ne va pas pouvoir concurrencer un serveur Apache avec ce petit contrôleur, mais quand même le minimum vital va très vite devenir impossible à gérer.

De plus, on va se retrouver avec tout le code HTML dans la RAM du NodeMCU qui est très précieuse (< 40kB).

## Moyens
Le truc étant de sauvegarder les pages HTML dans la FLASH du NodeMCU (on en a assez < 3.5MB) et de le lire à la volée ligne après lignes. Ceci va nous permettre d'économiser la RAM mais aussi de résoudre le problème du multi pages.

L'autre truc, c'est *d'insérer* du code Lua dans le code HTML (Lua inline) et au moment de la *lecture* du fichier HTML par le NodeMCU, ligne par ligne, le code Lua *inséré* pourra être exécuté. Et par la même, rendre dynamique la page WEB très facilement.

Par exemple on peut afficher la température du capteur *temp_capteur1* mesuré par le NodeMCU très simplement avec:

```
...
<h1>Mesure de température</h1>
La température est:
<%
zout(temp_capteur1.."°C")
%>
<br>
...
```
Ecrire de jolies interfaces WEB utilisateur (interface de commande d'un robot, résultats de mesure d'une installation solaire) avec le NodeMCU devient très facile.

## Framework références
Il suffit simplement d'entourer le bloc de code Lua à exécuter sur le NodeMCU par les balises **<%** et **%>** directement dans le code HTML à envoyer.

La *sortie*, le fameux **print** de Lua est remplacé par **zout**.

Et c'est tout !

## Limitations
Afin de limiter au maximum la charge, il y a quelques limitations tout à fait acceptables pour une utilisation sur un microcontrôleur.

* Les balises **<%** et **%>** doivent être isolées sur une ligne.<br>
C'est à dire que tout se qui se trouve avant et après la balise est simplement ignoré !

* Pas d'imbrication de bloc Lua dans le code html.<br>
Typiquement on ne peut pas faire un bloc de bloc de Lua.
On peut par contre les chainer,avoir plusieurs blocs Lua dans le code html.

* Maximum de 1'024 bytes la longueur d'une ligne dans le fichier html.<br>
C'est une limitation du SDK TCP du microcontrôleur.

* Exactement comme sur le NodeMCU le fait d'utiliser une variable non définie (nil) fait crasher le microcontôleur.<br>
Comme par exemple afficher l'état un capteur qui n'existe pas, fera crasher le microcontrôleur, il n'y a pas de vérification.<br>
Il faudra donc bien vérifier le code Lua que l'on insère dans le code HTML !

* Mono-tâche à cause de l'utilisation de variables *globales*.<br>
Là, c'est plus embêtant, c'est à dire que l'on ne peut servir plusieurs page WEB en même temps à cause de l'obligation d'utiliser des variables *globales* pour pouvoir exécuter du code Lua venant d'un fichier *texte*.<br>
Mais vu que c'est utilisé pour des *interface WEB* sur un petit microcontrôleur et non un serveur WEB puissant ce n'est pas trop catastrophique.


## Exemples
