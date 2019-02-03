-- Scripts pour tester le tri (sort) d'un tableau d'adresse MAC en fonction du signal de réception
-- pour les tests on charge un fichier CSV de d'adresse MAC sniffées précédemment
-- source: https://wxlua.developpez.com/tutoriels/lua/general/cours-complet/#L6-f
-- source: https://wxlua.developpez.com/tutoriels/lua/general/cours-complet/#L13-g

print("\n tst_sort.lua zf190202.1400 \n")



-- send a file from memory to the client; max. line length = 1024 bytes!
function send_file(client, filename)
  if file.open(filename, "r") then
    repeat
      local line=file.read('\n')
      if line then
        client:send(line)
      end
    until not line    
    file.close()
  end
end





--f= "set_time.lua"   if file.exists(f) then dofile(f) end

-- apzuzu6 38:2c:4a:4e:d3:d8

zmac_adrs={}
zmac_adrs["b8:d7:af:a6:bd:86"]={["zname"]="S7 zf"}
zmac_adrs["cc:c0:79:7d:f5:d5"]={["zname"]="S7 Mélanie"}
zmac_adrs["5c:f9:38:a1:f7:f0"]={["zname"]="MAC zf"}
zmac_adrs["d8:30:62:5a:d6:3a"]={["zname"]="IMAC Maman"}
zmac_adrs["88:e9:fe:6b:ec:1e"]={["zname"]="MAC Luc"}
zmac_adrs["0c:2c:54:b3:c5:1a"]={["zname"]="HU Nicolas"}
zmac_adrs["c0:a6:00:bf:4e:43"]={["zname"]="IPHONE Maeva"}






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

function zsniff(T)

    if T.RSSI > -60 then
--        print("\n\tMAC: ".. T.MAC.."\n\tRSSI: "..T.RSSI)
--    ztime()
        if zmac_adrs[T.MAC] == nil then
            print("Oh une inconnue !")
            zmac_adrs[T.MAC]={}
        end
    --    zmac_adrs[T.MAC]["ztime"]=string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"], tm["day"], tm["hour"], tm["min"], tm["sec"])
        if zmac_adrs[T.MAC]["zrssi"] == nil then
            zmac_adrs[T.MAC]["zrssi"]=T.RSSI
        else
            zmac_adrs[T.MAC]["zrssi"]=zround((4*zmac_adrs[T.MAC]["zrssi"]+T.RSSI)/5, 0)
        end
        if zmac_adrs[T.MAC]["zname"] ~= nil then
            print("Bonjour "..zmac_adrs[T.MAC]["zname"].." !")
        end
    end
end

wifi.eventmon.register(wifi.eventmon.AP_PROBEREQRECVED, zsniff)
--[[
wifi.eventmon.unregister(wifi.eventmon.AP_PROBEREQRECVED)
zshow()
]]


