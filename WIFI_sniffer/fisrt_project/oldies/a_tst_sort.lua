-- Scripts pour tester le tri (sort) d'un tableau d'adresse MAC en fonction du signal de réception
-- pour les tests on charge un fichier CSV de d'adresse MAC sniffées précédemment
-- source: https://wxlua.developpez.com/tutoriels/lua/general/cours-complet/#L6-f
-- source: https://wxlua.developpez.com/tutoriels/lua/general/cours-complet/#L13-g

print("\n a_tst_sort.lua zf190209.2014 \n")

zmac_adrs={}
zmac_adrs_index={}



function zshow()
    for i=1, #zmac_adrs do
        print(i,zmac_adrs[i])
        zindex, zadrs, zname, zrssi, ztime = zmac_adrs[i]:match("([^,]+),([^,]+),([^,]+),([^,]+),([^,]+)")
        print("toto",zindex, zadrs, zname, zrssi, ztime, "tutu")
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
                zmac_adrs[#zmac_adrs+1]=line:sub(1, -2)
--                zmac_adrs_index[zfield[2]]=#zmac_adrs
            end
        until not line    
        file.close()
    end
end


--zload_tableau()

--print("tableau chargé")     --important, c'est pour attendre que le tableau soit complètement chargé !
--zshow()


function zsort_tableau()
    print("tri du tableau")
--    table.sort(zmac_adrs, function(a,b) return a.zrssi < b.zrssi end)
    table.sort(zmac_adrs, function(a,b) 
        return a:match("[^,]+,[^,]+,[^,]+,([^,]+),[^,]+") < b:match("[^,]+,[^,]+,[^,]+,([^,]+),[^,]+") 
    end)
end



function test_ram_table()
    zmac_adrs={}
    for i=1, 70 do
        print(i)
        --zmac_adrs[#zmac_adrs+1]={adrs="b8:d7:af:a6:bd:86", zname=0, zrssi=-50, ztime= 0}
        zmac_adrs[i]={adrs="b8:d7:af:a6:bd:86", zname=0, zrssi=-50, ztime= 0}
    end
end


function find_adrs(zadrs)
    for i=1, #zmac_adrs do
        if zadrs == zmac_adrs[i]:match("[^,]+,([^,]+),[^,]+,[^,]+,[^,]+") then
            return zmac_adrs[i]
        end
    end
    return nil
end





--[[
test_ram_table()

zload_tableau()
zsort_tableau()
zshow()

print(find_adrs("02:ec:f1:a1:c8:29"))
print(find_adrs("da:a1:19:b6:6b:50"))






print(zmac_adrs_index["02:ec:f1:a1:c8:29"])
print(zmac_adrs[70])

t1, t2, t3, t4=zmac_adrs[70]:match("[^,]+,[^,]+,[^,]+,([^,]+),[^,]+")
print(t1, t2, t3, t4)
print(zmac_adrs[70]:match("[^,]+,[^,]+,[^,]+,([^,]+),[^,]+"))

zmac_adrs=nil
zmac_adrs={}

zmac_adrs_index=nil
zmac_adrs_index={}


zmac_adrs_index={}
zmac_adrs_index["toto"]=3
print(zmac_adrs_index["toto"])


]]




function zround(num, dec)
    local mult = 10^(dec or 0)
    return math.floor(num * mult + 0.5) / mult
end



