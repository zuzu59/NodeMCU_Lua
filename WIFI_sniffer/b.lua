-- Scripts pour tester le sniffer de smartphone qui essaient de se connecter sur des AP WIFI
-- source: https://nodemcu.readthedocs.io/en/dev/modules/wifi/#wifieventmonregister

print("\n b.lua zf190119.1920 \n")

--f= "set_time.lua"   if file.exists(f) then dofile(f) end

-- apzuzu6 38:2c:4a:4e:d3:d8

zmac_adrs={}
zmac_adrs["b8:d7:af:a6:bd:86"]={["zname"]="S7 zf"}
zmac_adrs["cc:c0:79:7d:f5:d5"]={["zname"]="S7 Mélanie"}
zmac_adrs["5c:f9:38:a1:f7:f0"]={["zname"]="MAC zf"}
zmac_adrs["d8:30:62:5a:d6:3a"]={["zname"]="IMAC Maman"}

function zshow()
    for k, v in pairs(zmac_adrs) do
        print(k,zmac_adrs[k]["zname"],zmac_adrs[k]["zrssi"],zmac_adrs[k]["ztime"]) 
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
    print("\n\tMAC: ".. T.MAC.."\n\tRSSI: "..T.RSSI)
    ztime()
    if zmac_adrs[T.MAC] == nil then
        print("Oh une inconnue !")
        zmac_adrs[T.MAC]={}
    end
    zmac_adrs[T.MAC]["ztime"]=string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"], tm["day"], tm["hour"], tm["min"], tm["sec"])
    if zmac_adrs[T.MAC]["zrssi"] == nil then
        zmac_adrs[T.MAC]["zrssi"]=T.RSSI
    else
        zmac_adrs[T.MAC]["zrssi"]=zround((4*zmac_adrs[T.MAC]["zrssi"]+T.RSSI)/5, 0)
    end
    if zmac_adrs[T.MAC]["zname"] ~= nil then
        print("Bonjour "..zmac_adrs[T.MAC]["zname"].." !")
    end
end

wifi.eventmon.register(wifi.eventmon.AP_PROBEREQRECVED, zsniff)
--[[
wifi.eventmon.unregister(wifi.eventmon.AP_PROBEREQRECVED)
]]


