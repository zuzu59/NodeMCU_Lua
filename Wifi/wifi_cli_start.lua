-- Petit script pour connecter le NodeMCU sur un AP Wifi avec l'accompte sauvé en EEPROM
print("\wifi_clidef_start.lua   zf180822.1412   \n")

local zmodewifi=wifi.getmode()
if zmodewifi == wifi.NULLMODE then
    print("WIFI mode CLI only")
    wifi.setmode(wifi.STATION)
elseif zmodewifi == wifi.SOFTAP then
    print("WIFI mode AP+CLI")
    wifi.setmode(wifi.STATIONAP)
else
    print("on ne fait rien car cela tourne déjà !")
end
wifi.sta.connect()
dofile("wifi_get_ip.lua")


