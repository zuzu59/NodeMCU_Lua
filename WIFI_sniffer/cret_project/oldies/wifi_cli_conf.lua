-- Petit script pour configurer le client WIFI du NodeMCU

function wifi_cli_conf()
    print("\n wifi_cli_conf.lua   zf191030.1358   \n")
    
    -- les secrets sont maintenant initialisés par boot.lua !
    wifi.sta.config{ssid=cli_ssid, pwd=cli_pwd, auto=true, save=true}
end

wifi_cli_conf()
--wifi_cli_conf=nil
