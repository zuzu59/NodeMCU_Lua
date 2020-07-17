-- Démarre le WIFI en mode AP
print("\n wifi_ap_start.lua   zf200717.1728   \n")

wifi.setmode(wifi.SOFTAP)
wifi.ap.config({ ssid = "web_srv", pwd = "12345678" })
dofile("wifi_info.lua")



--wifi.ap.config({ ssid = "NodeMCU ".."btn "..wifi.ap.getmac(), pwd = "12345678" })
