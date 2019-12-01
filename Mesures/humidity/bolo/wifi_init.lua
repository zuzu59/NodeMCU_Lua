-- Petit script pour initaliser la couche WIFI

function wifi_init()
    print("\n wifi_init.lua   zf191030.2040   \n")
    -- charge les secrets pour le wifi
    f= "secrets_wifi.lua"    if file.exists(f) then dofile(f) end
    
    wifi.setmode(wifi.STATIONAP,true)
    
    wifi.ap.config({ ssid = ap_ssid.." "..wifi.ap.getmac(), pwd = ap_pwd, save=true })

    wifi.sta.config{ssid=cli_ssid, pwd=cli_pwd, auto=true, save=true}
    wifi.sta.autoconnect(1)
    wifi.sta.connect()
end

wifi_init()

