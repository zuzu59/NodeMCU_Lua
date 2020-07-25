-- Scripts pour tester l'écoute des AP WIFI

print("\n wifi_scan.lua zf200725.1053 \n")

f= "secrets_project.lua"    if file.exists(f) then dofile(f) end

-- https://www.epochconverter.com/
ztime2020 = 1577836800      -- Unix time pour 1.1.2020 0:0:0 GMT

-- sauvegarde les données dans la flash du NodeMCU
function save_flash(zstr_ap_wifi)
    ztime1 = tostring(rtctime.get() + 2*3600 - ztime2020)
    local zstr = ztime1..", "..zstr_ap_wifi
    if verbose then print("saving to flash: "..zstr) end
    file.open(z_logs_ap_wifi, "a+")   file.writeline(zstr)   file.close()
end

-- print AP list in new format
function scan_wifi()
    print(ztime())
    function listap(t)
        print("start display liste ap wifi...")
        for k,v in pairs(t) do
            -- local ssid, rssi, authmode, channel = string.match(v, "([^,]+),([^,]+),([^,]+),([^,]*)")
            -- print(ssid,rssi)
            -- print(k.." : "..v)
            -- local zstr = k..", "..v
            local zstr = v
            save_flash(zstr)
        end
        print("end display...")
        dsleep_on()
    end
    print("wifi scan...")
    wifi.sta.getap(1, listap)
end

--[[
scan_wifi()
]]



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
