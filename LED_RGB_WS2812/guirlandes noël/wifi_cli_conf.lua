-- Petit script pour configurer le client WIFI du NodeMCU

print("\n wifi_cli_conf.lua   zf181205.1931   \n")

--credentials par défaut
cli_ssid="3g-s7"
cli_pwd="12234567"

--ses propre credentials
f= "credentials.lua"    if file.exists(f) then dofile(f) end

wifi.sta.config{ssid=cli_ssid, pwd=cli_pwd, save=true}
