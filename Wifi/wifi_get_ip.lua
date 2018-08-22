-- Petit script pour obtenir l'adresse IP du NodeMCU connecté sur un AP Wifi
print("\wifi_get_ip.lua   zf180822.1522   \n")

wifitimer1=tmr.create()
tmr.alarm(wifitimer1, 1000, tmr.ALARM_AUTO , function()
    if wifi.sta.getip() == nil then
        print("Connecting to AP...")
    else
        tmr.stop(wifitimer1)
        dofile("wifi_info.lua")
    end
end)

