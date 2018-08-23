-- Démarre le WIFI en mode AP
print("\n wifi_ap_stop.lua   zf180823.1039   \n")

local zmodewifi=wifi.getmode()
if zmodewifi == wifi.SOFTAP then
    wifi.setmode(wifi.NULLMODE)
elseif zmodewifi == wifi.STATIONAP then
    wifi.setmode(wifi.STATION)
end
print("WIFI AP arrêté")
