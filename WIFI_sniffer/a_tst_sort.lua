-- Scripts pour tester le tri (sort) d'un tableau d'adresse MAC en fonction du signal de réception
-- pour les tests on charge un fichier CSV de d'adresse MAC sniffées précédemment
-- source: https://wxlua.developpez.com/tutoriels/lua/general/cours-complet/#L6-f
-- source: https://wxlua.developpez.com/tutoriels/lua/general/cours-complet/#L13-g

print("\n a_tst_sort.lua zf190202.1559 \n")



-- send a file from memory to the client; max. line length = 1024 bytes!
function zload_tableau()
    zmac_adrs={}
    filename="tst_sniffer_wifi1.csv"
    if file.open(filename, "r") then
    repeat
      local line=file.read('\n')
      if line then
        print("line: "..line)
    
        local zfield = {}
        for part in line:gmatch("[^,]+") do
            zfield[#zfield+1] = part
    --            print(part)
        end

        zmac_adrs[zfield[2]]={["zname"]=zfield[3],["zrssi"]=zfield[4], ["ztime"]=zfield[5]}


      end
    until not line    
    file.close()
  end
end


zload_tableau()


--[[
zload_tableau()
zshow()
]]






function zshow()
    i=1
    for k, v in pairs(zmac_adrs) do
        print(i..", ", k..", ", zmac_adrs[k]["zname"], zmac_adrs[k]["zrssi"], zmac_adrs[k]["ztime"]) 
        i=i+1
    end
end
--[[
zshow()
]]

function zround(num, dec)
    local mult = 10^(dec or 0)
    return math.floor(num * mult + 0.5) / mult
end


--[[
zload_tableau()
zshow()
]]


