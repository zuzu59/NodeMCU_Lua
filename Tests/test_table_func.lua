-- Tests de fonctions 'redirigées' dans une variable
-- faut voir encore ceci:
-- https://stackoverflow.com/questions/1791234/lua-call-function-from-a-string-with-function-name
 
print("\n test_table_func.lua   zf180830.1224   \n")


function toto()
  print("toto")
end

function tutu(f)
  f()
end

print("fonction dans une fonction")
tutu(toto)

print("fonction dans une variable")
titi=toto
titi()
