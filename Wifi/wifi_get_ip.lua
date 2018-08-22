-- Petit script pour obtenir l'adresse IP du NodeMCU connecté sur un AP Wifi
print("\wifi_get_ip.lua   zf180822.1422   \n")

wifitimer1=tmr.create()
tmr.alarm(wifitimer1, 1000, tmr.ALARM_AUTO , function()
    if wifi.sta.getip() == nil then
        print("Connecting to AP...")
    else
        tmr.stop(wifitimer1)
        do
            local sta_config=wifi.sta.getconfig(true)
            print(string.format("Current client config:\n\tssid:\"%s\"\tpassword:\"%s\"\n\tbssid:\"%s\"\tbssid_set:%s", sta_config.ssid, sta_config.pwd, sta_config.bssid, (sta_config.bssid_set and "true" or "false")))
        end    
        print("Connected IP:\n\t"..wifi.sta.getip())
    end
end)

