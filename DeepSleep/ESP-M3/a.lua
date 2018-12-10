-- Scripts pour tester l'écoute des AP WIFI

print("\n a.lua zf181211.0016 \n")

--f= "wifi_ap_stop.lua"   if file.exists(f) then dofile(f) end
--f= "wifi_cli_conf.lua"   if file.exists(f) then dofile(f) end
--f= "wifi_cli_start.lua"   if file.exists(f) then dofile(f) end
--f= "telnet_srv.lua"   if file.exists(f) then dofile(f) end
--f= "web_ide2.lua"   if file.exists(f) then dofile(f) end
--f= "dsleep.lua"   if file.exists(f) then dofile(f) end


-- print AP list in new format
function a()
    ztime()
    function listap(t)
        print("")
        for k,v in pairs(t) do
            print(k.." : "..v)
        end
        print("")
    end
    wifi.sta.getap(1, listap)
end

--a()

--[[
-- Print AP list that is easier to read
function listap(t) -- (SSID : Authmode, RSSI, BSSID, Channel)
    print("\n\t\t\tSSID\t\t\t\t\tBSSID\t\t\t  RSSI\t\tAUTHMODE\t\tCHANNEL")
    for bssid,v in pairs(t) do
        local ssid, rssi, authmode, channel = string.match(v, "([^,]+),([^,]+),([^,]+),([^,]*)")
        print(string.format("%32s",ssid).."\t"..bssid.."\t  "..rssi.."\t\t"..authmode.."\t\t\t"..channel)
    end
end
wifi.sta.getap(1, listap)


]]
