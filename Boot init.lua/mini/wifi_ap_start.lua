-- Démarre le WIFI en mode AP

print("\n wifi_ap_start.lua   zf181118.2331   \n")

local zmodewifi=wifi.getmode()
if zmodewifi == wifi.NULLMODE then
    print("WIFI mode AP only")
    wifi.setmode(wifi.SOFTAP)
elseif zmodewifi == wifi.STATION then
    print("WIFI mode AP+CLI")
    wifi.setmode(wifi.STATIONAP)
end
wifi.ap.config({ ssid = "NodeMCU "..wifi.ap.getmac(), pwd = "12345678" })
if file.exists("wifi_info.lua") then dofile("wifi_info.lua") end
