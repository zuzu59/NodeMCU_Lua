-- Petit script pour obtenir l'adresse IP du NodeMCU connecté sur un AP Wifi
print("\n wifi_get_ip.lua   zf200717.1652   \n")

wifitimer1=tmr.create()
wifitimer1:alarm(1000, tmr.ALARM_AUTO , function()
    if wifi.sta.getip() == nil then
        print("Connecting to AP...")
    else
        wifitimer1:unregister()
        dofile("wifi_info.lua")
        gpio.write(zLED, gpio.LOW)   tmr.delay(10000)   gpio.write(zLED, gpio.HIGH)
    end
end)
