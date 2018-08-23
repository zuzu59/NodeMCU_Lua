-- Démarre le WIFI en mode AP
print("\n wifi_cli_stop.lua   zf180823.1039   \n")

local zmodewifi=wifi.getmode()
if zmodewifi == wifi.STATION then
    wifi.setmode(wifi.NULLMODE)
elseif zmodewifi == wifi.STATIONAP then
    wifi.setmode(wifi.SOFTAP)
end
print("WIFI CLI arrêté")
