-- Scripts pour tester le sniffer de smartphone qui essaient de se connecter sur des AP WIFI
-- source: https://nodemcu.readthedocs.io/en/dev/modules/wifi/#wifieventmonregister

print("\n b.lua zf190119.1710 \n")

--f= "wifi_ap_stop.lua"   if file.exists(f) then dofile(f) end
--f= "wifi_cli_conf.lua"   if file.exists(f) then dofile(f) end
--f= "wifi_cli_start.lua"   if file.exists(f) then dofile(f) end
--f= "telnet_srv.lua"   if file.exists(f) then dofile(f) end
--f= "web_ide2.lua"   if file.exists(f) then dofile(f) end
--f= "dsleep.lua"   if file.exists(f) then dofile(f) end

-- apzuzu6 38:2c:4a:4e:d3:d8
-- S7 b8:d7:af:a6:bd:86
-- maczf 11 5c:f9:38:a1:f7:f0

zmac_adrs={}
zmac_adrs["b8:d7:af:a6:bd:86"]={["zname"]="S7"}
zmac_adrs["5c:f9:38:a1:f7:f0"]={["zname"]="maczf"}

function zdisp_table()
    for k, v in pairs(zmac_adrs) do
        print(k,zmac_adrs[k]["zname"],zmac_adrs[k]["zrssi"]) 
    end
end

--[[
zdisp_table()
]]

function zsniff(T)
--    print("\n\tAP - PROBE REQUEST RECEIVED".."\n\tMAC: ".. T.MAC.."\n\tRSSI: "..T.RSSI)
    print("\n\tMAC: ".. T.MAC.."\n\tRSSI: "..T.RSSI)

    if zmac_adrs[T.MAC] == nil then
        print("Oh une inconnue !")
        zmac_adrs[T.MAC]={}
    end
    if zmac_adrs[T.MAC]["zrssi"] == nil then
        zmac_adrs[T.MAC]["zrssi"]=T.RSSI
    else
        zmac_adrs[T.MAC]["zrssi"]=(4*zmac_adrs[T.MAC]["zrssi"]+T.RSSI)/5
    end
    if zmac_adrs[T.MAC]["zname"] ~= nil then
        print("Bonjour "..zmac_adrs[T.MAC]["zname"].." !")
    end

end

--[[
wifi.eventmon.unregister(wifi.eventmon.AP_PROBEREQRECVED)
]]
wifi.eventmon.register(wifi.eventmon.AP_PROBEREQRECVED, zsniff)


