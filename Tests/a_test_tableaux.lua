-- Tests de tableaux
-- source:
 
print("\n a_test_tableaux.lua   zf190119.1538   \n")


ztableau={}
ztableau["toto"]=12
print(ztableau["toto"])
print(ztableau.toto)

zmac_adrs={}
zmac_adrs["38:2c:4a:4e:d3:d8"]={}
zmac_adrs["38:2c:4a:4e:d3:d8"]["zname"]="apzuzu6"
zmac_adrs["38:2c:4a:4e:d3:d8"]["ztime_first"]=12
zmac_adrs["38:2c:4a:4e:d3:d8"]["ztime_last"]=34

zt="38:2c:4a:4e:d3:d8"
print("MAC: "..zt..", "..zmac_adrs[zt]["zname"])
print("Time_first: "..zmac_adrs[zt]["ztime_first"])
print("Time_last: "..zmac_adrs[zt]["ztime_last"])








--[[
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
]]
