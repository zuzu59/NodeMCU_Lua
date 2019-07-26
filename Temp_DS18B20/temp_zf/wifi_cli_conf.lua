-- Petit script pour configurer le client WIFI du NodeMCU

function wifi_cli_conf()
    print("\n wifi_cli_conf.lua   zf190726.1912   \n")
    
    -- les secrets sont maintenant initialisés par boot.lua !
    wifi.sta.config{ssid=cli_ssid, pwd=cli_pwd, save=true}
end

wifi_cli_conf()
wifi_cli_conf=nil
