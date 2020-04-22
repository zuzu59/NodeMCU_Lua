-- Petit script pour configurer le client WIFI du NodeMCU
print("\n wifi_cli_conf.lua   zf181101.1743   \n")

wifi.sta.config{ssid="3g-s7", pwd="xxx", save=true}

