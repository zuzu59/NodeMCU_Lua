-- Petit script pour configurer le client WIFI du NodeMCU
print("\n wifi_cli_conf.lua   zf190808.1559   \n")

wifi.sta.config{ssid="3g-s7", pwd="12234567", save=true}

