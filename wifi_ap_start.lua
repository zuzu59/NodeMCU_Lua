-- Démarre un WIFI AP
print("\wifi_ap_start.lua   zf20180724.2220   \n")

wifi.setmode(wifi.SOFTAP)
wifi.ap.config({ ssid = "NodeMCU", pwd = "12345678" })
