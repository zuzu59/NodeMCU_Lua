-- écriture d'un script dans un fichier et l'exécute
-- zf180717.1517
jj = [[
 print("toto")
 print("tutu")
]]

file.open("toto1518.lua","w")
file.write(jj)
file.close()
dofile("toto1518.lua")
