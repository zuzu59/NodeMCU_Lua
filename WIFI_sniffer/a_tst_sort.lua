-- Scripts pour tester le tri (sort) d'un tableau d'adresse MAC en fonction du signal de réception
-- pour les tests on charge un fichier CSV de d'adresse MAC sniffées précédemment
-- source: https://wxlua.developpez.com/tutoriels/lua/general/cours-complet/#L6-f
-- source: https://wxlua.developpez.com/tutoriels/lua/general/cours-complet/#L13-g

print("\n a_tst_sort.lua zf190209.1512 \n")

zmac_adrs={}
zmac_adrs_index={}



function zshow()
    i=1
    for k, v in ipairs(zmac_adrs) do
        print(i..", "..k, zmac_adrs[k]["adrs"]..", ".. zmac_adrs[k]["zname"], zmac_adrs[k]["zrssi"], zmac_adrs[k]["ztime"]) 
        i=i+1
    end
end

function zload_tableau()
    filename="tst_sniffer_wifi1.csv"
    if file.open(filename, "r") then
        repeat
            local line=file.read('\n')
            if line then
--                print("line: "..line)
                local zfield = {}   local zpart=""
                for zpart in line:gmatch("[^,]+") do
                    zfield[#zfield+1] = zpart
                end
                -- :sub(1, -2) , ça enlève le \n à la fin de la ligne lors de la lecture du fichier !
                zmac_adrs[zfield[2]]={["zname"]=zfield[3],["zrssi"]=zfield[4], ["ztime"]=zfield[5]:sub(1, -2)}
--                zmac_adrs[#zmac_adrs+1]={["adrs"]=zfield[2], ["zname"]=zfield[3], ["zrssi"]=zfield[4], ["ztime"]=zfield[5]:sub(1, -2)}
--                zmac_adrs_index[zfield[2]]=#zmac_adrs
            end
        until not line    
        file.close()
    end
end


zload_tableau()

print("tableau chargé")     --important, c'est pour attendre que le tableau soit complètement chargé !
zshow()


function zsort_tableau()
    print("tri du tableau")
    table.sort(zmac_adrs, function(a,b) return a.zrssi < b.zrssi end)
end


--[[
zload_tableau()
zsort_tableau()
zshow()

print(zmac_adrs_index["02:ec:f1:a1:c8:29"])
print(zmac_adrs[70].adrs)

zmac_adrs=nil
zmac_adrs_index=nil


zmac_adrs_index={}
zmac_adrs_index["toto"]=3
print(zmac_adrs_index["toto"])


]]




function zround(num, dec)
    local mult = 10^(dec or 0)
    return math.floor(num * mult + 0.5) / mult
end



