-- Petit script pour connecter le NodeMCU sur un AP Wifi avec l'accompte sauvé en EEPROM
print("\n wifi_cli_start.lua   zf181119.2359   \n")

local zmodewifi=wifi.getmode()
if zmodewifi == wifi.NULLMODE then
    print("WIFI mode CLI only")
    wifi.setmode(wifi.STATION)
elseif zmodewifi == wifi.SOFTAP then
    print("WIFI mode AP+CLI")
    wifi.setmode(wifi.STATIONAP)
end
wifi.sta.autoconnect(1)
wifi.sta.connect()
f= "wifi_get_ip.lua"   if file.exists(f) then dofile(f) end
