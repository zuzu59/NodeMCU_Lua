-- Tests d'exécution de scripts Lua stocké dans une variable string
-- cela permet par exemple d'exécuter une fonction que l'on aurait lue dans un fichier texte
-- le truc consiste à utiliser la commande loadstring !
-- source:
 
print("\n a_test_exec_string.lua   zf1901123.2000   \n")


-- fonction que l'on veut exécuter
function t3()
    print("toto")
    print("tutu")
end


-- variable texte qui contient le nom de la fonction à exécuter
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


