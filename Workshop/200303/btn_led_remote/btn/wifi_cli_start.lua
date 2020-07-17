-- Petit script pour connecter le NodeMCU sur un AP Wifi
print("\n wifi_cli_start.lua   zf200717.1650   \n")

wifi.sta.config{ssid="btn_led", pwd="12345678"}
wifi.setmode(wifi.STATION)
wifi.sta.connect()

dofile("wifi_get_ip.lua")
