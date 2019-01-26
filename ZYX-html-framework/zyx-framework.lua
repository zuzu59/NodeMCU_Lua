-- Pico framework pour pouvoir insérer du code LUA dans du code HTML afin de 
-- pouvoir faire des pages WEB actives très simplement en LUA
-- source: y'en a pas
 
print("\n zyx-framework.lua   zf1901123.2000   \n")


-- fonction que l'on veut exécuter
function t3()
    print("toto")
    print("tutu")
end


-- variable texte qui contient le nom de la fonction à éxécuter
t2="t3()"

-- exécution de la variable texte
t1=loadstring(t2)
t1()

-- on peut aussi l'écrire ainsi, mais c'est moins lisible
loadstring(t2)()


-- on peut même carément écrire un bout de code dans une variable texte
-- et rediriger le résutat dans une fonction de sortie

-- la fonction de sortie
function zoutput(zin)
    print(zin)
end

-- le bout de code dans la variable
t4=[[
for i=1,5 do
    zoutput("la valeur est "..i.."<br>")
end
]]

-- exécution de contenu de la variable
loadstring(t4)()


