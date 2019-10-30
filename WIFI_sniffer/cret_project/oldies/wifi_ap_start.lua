-- Démarre le WIFI en mode AP

print("\n wifi_ap_start.lua   zf191030.1358   \n")

local zmodewifi=wifi.getmode()
if zmodewifi == wifi.NULLMODE then
    print("apWIFI mode AP only")
    wifi.setmode(wifi.SOFTAP,save)
elseif zmodewifi == wifi.STATION then
    print("apWIFI mode AP+CLI")
    wifi.setmode(wifi.STATIONAP,save)
end
wifi.ap.config({ ssid = "NodeMCU "..wifi.ap.getmac(), pwd = "12345678" })
--f= "wifi_info.lua"   if file.exists(f) then dofile(f) end
