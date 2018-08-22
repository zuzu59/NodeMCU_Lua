-- Démarre le WIFI en mode AP
print("\wifi_ap_stop.lua   zf180822.1425   \n")

local zmodewifi=wifi.getmode()
if zmodewifi == wifi.SOFTAP then
    wifi.setmode(wifi.NULLMODE)
elseif zmodewifi == wifi.STATIONAP then
    wifi.setmode(wifi.STATION)
end
print("WIFI AP arrêté")

