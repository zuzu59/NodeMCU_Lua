-- Déconnecte le WIFI
print("\n wifi_off.lua   zf180822.0959   \n")

wifi.setmode(wifi.NULLMODE)

--[[
print(wifi.NULLMODE, wifi.STATION, wifi.SOFTAP, wifi.STATIONAP)
print(wifi.getmode())
]]
