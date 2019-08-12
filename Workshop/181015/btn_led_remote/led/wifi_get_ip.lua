-- Petit script pour obtenir l'adresse IP du NodeMCU connecté sur un AP Wifi
print("\n wifi_get_ip.lua   zf190808.1600   \n")

wifitimer1=tmr.create()
wifitimer1:alarm(1000, tmr.ALARM_AUTO , function()
    if wifi.sta.getip() == nil then
        print("Connecting to AP...")
    else
        wifitimer1:stop()
        dofile("wifi_info.lua")
    end
end)
