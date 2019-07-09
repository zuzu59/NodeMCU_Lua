-- Petit script pour configurer le client WIFI du NodeMCU

function wifi_cli_conf()
    print("\n wifi_cli_conf.lua   zf190709.2147   \n")
    
    --secrets par défaut
    --cli_ssid="3g-s7"
    cli_ssid="3G-zf"
    cli_pwd="12234567"
    
    --ses propres secrets
    f= "secrets_temp_zf_int_1er.lua"    if file.exists(f) then dofile(f) end
    f= "secrets_temp_zf_out_nord.lua"    if file.exists(f) then dofile(f) end
    f= "secrets_temp_zf_out_sud.lua"    if file.exists(f) then dofile(f) end
    
    wifi.sta.config{ssid=cli_ssid, pwd=cli_pwd, save=true}
end

wifi_cli_conf()
wifi_cli_conf=nil
cli_ssid=nil
cli_pwd=nil
