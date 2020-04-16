-- Petit script pour configurer le client WIFI du NodeMCU
print("\n wifi_cli_conf.lua   zf200303.1533   \n")

wifi.sta.config{ssid="NodeMCU btn 3a:2b:78:04:2d:2d", pwd="12345678", save=true}
