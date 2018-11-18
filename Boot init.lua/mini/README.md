# Version minimaliste d'un init.lua

Test au moment du boot qui a été la cause de boot et alors prend une décision en conséquence.

Si le boot a été causé par un power on, alors attend 10 secondes avant de démarrer le fichier boot.lua. Cela permet d'avoir le temps de prendre une action en cas de plantage en boucle.

Dans les autres cas, démarre sans autre le fichier boot.lua pour autant qu'il existe.


zf181118.2231

