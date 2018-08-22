-- Petit script pour configurer le client WIFI du NodeMCU
print("\wifi_cli_conf.lua   zf180822.1407   \n")

wifi.sta.config{ssid="Hugo", pwd="tototutu", save=true}
