-- Démarre le WIFI en mode AP
print("\n wifi_ap_start.lua   zf180824.2000   \n")

local zmodewifi=wifi.getmode()
if zmodewifi == wifi.NULLMODE then
    print("WIFI mode AP only")
    wifi.setmode(wifi.SOFTAP)
elseif zmodewifi == wifi.STATION then
    print("WIFI mode AP+CLI")
    wifi.setmode(wifi.STATIONAP)
end
wifi.ap.config({ ssid = "NodeMCU "..wifi.ap.getmac(), pwd = "12345678" })
dofile("wifi_info.lua")
