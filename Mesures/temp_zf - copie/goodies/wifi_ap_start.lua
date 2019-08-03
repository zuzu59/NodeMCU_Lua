-- Démarre le WIFI en mode AP

function wifi_ap_start()
    print("\n wifi_ap_start.lua   zf190310.1511   \n")

    local zmodewifi=wifi.getmode()
    if zmodewifi == wifi.NULLMODE then
        print("WIFI mode AP only")
        wifi.setmode(wifi.SOFTAP)
    elseif zmodewifi == wifi.STATION then
        print("WIFI mode AP+CLI")
        wifi.setmode(wifi.STATIONAP)
    end
    wifi.ap.config({ ssid = "NodeMCU "..wifi.ap.getmac(), pwd = "12345678" })
    --f= "wifi_info.lua"   if file.exists(f) then dofile(f) end
end

wifi_ap_start()
wifi_ap_start=nil
