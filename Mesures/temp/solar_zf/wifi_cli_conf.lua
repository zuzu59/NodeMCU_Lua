-- Petit script pour configurer le client WIFI du NodeMCU

function wifi_cli_conf()
    print("\n wifi_cli_conf.lua   zf190601.1328   \n")
    
    --credentials par défaut
    --cli_ssid="3g-s7"
    cli_ssid="3G-zf"
    cli_pwd="xxx"
    
    --ses propre credentials
    f= "credentials_solar.lua"    if file.exists(f) then dofile(f) end
    
    wifi.sta.config{ssid=cli_ssid, pwd=cli_pwd, save=true}
end

wifi_cli_conf()
wifi_cli_conf=nil
cli_ssid=nil
cli_pwd=nil
