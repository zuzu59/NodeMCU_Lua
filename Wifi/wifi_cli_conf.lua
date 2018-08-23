-- Petit script pour configurer le client WIFI du NodeMCU
print("\n wifi_cli_conf.lua   zf180823.1039   \n")

wifi.sta.config{ssid="Hugo", pwd="tototutu", save=true}
