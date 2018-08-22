-- Démarre le WIFI en mode AP
print("\wifi_ap_stop.lua   zf180822.1425   \n")

local zmodewifi=wifi.getmode()
if zmodewifi == wifi.SOFTAP then
    wifi.setmode(wifi.NULLMODE)
elseif zmodewifi == wifi.STATIONAP then
    wifi.setmode(wifi.STATION)
end
print("WIFI AP arrêté")




--[[
wifi.setmode(wifi.NULLMODE)
print(wifi.ap.getconfig())
print(wifi.ap.getmac())
print(wifi.getdefaultmode())

print(wifi.getmode())
print(wifi.NULLMODE, wifi.STATION, wifi.SOFTAP, wifi.STATIONAP)

print(wifi.getphymode())
print(wifi.PHYMODE_B, wifi.PHYMODE_G, wifi.PHYMODE_N)
]]
