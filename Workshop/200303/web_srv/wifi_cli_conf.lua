-- Petit script pour configurer le client WIFI du NodeMCU
print("\n wifi_cli_conf.lua   zf200302.2300   \n")

wifi.sta.config{ssid="xxx", pwd="xxx", save=true}
