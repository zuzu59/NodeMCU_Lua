-- Petit script pour configurer le client WIFI du NodeMCU
print("\n wifi_cli_conf.lua   zf181011.2338   \n")

wifi.sta.config{ssid="apzuzu6", pwd="12234567", save=true}
