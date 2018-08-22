-- Démarre le WIFI en mode AP
print("\wifi_ap_start.lua   zf180822.1447   \n")

function zap_start()
    wifi.ap.config({ ssid = "NodeMCU "..wifi.ap.getmac(), pwd = "12345678" })
end

local zmodewifi=wifi.getmode()
if zmodewifi == wifi.NULLMODE then
    print("WIFI mode AP only")
    wifi.setmode(wifi.SOFTAP)
    zap_start()
elseif zmodewifi == wifi.STATION then
    print("WIFI mode AP+CLI")
    wifi.setmode(wifi.STATIONAP)
    zap_start()
else
    print("on ne fait rien car cela tourne déjà !")
end
dofile("wifi_info.lua")


