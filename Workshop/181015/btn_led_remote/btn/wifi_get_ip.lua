-- Petit script pour obtenir l'adresse IP du NodeMCU connecté sur un AP Wifi
print("\n wifi_get_ip.lua   zf200303.0000   \n")

wifitimer1=tmr.create()
wifitimer1:alarm(1000, tmr.ALARM_AUTO , function()
    if wifi.sta.getip() == nil then
        print("Connecting to AP...")
    else
        wifitimer1:unregister()
        dofile("wifi_info.lua")
        dofile("flash_led_xfois.lua")
    end
end)
