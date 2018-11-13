-- Petit script pour configurer le client WIFI du NodeMCU
print("\n wifi_cli_conf.lua   zf180824.2000   \n")

wifi.sta.config{ssid="apzuzu6", pwd="12234567", save=true}
