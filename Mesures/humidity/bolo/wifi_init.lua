-- Petit script pour initaliser la couche WIFI

function wifi_init()
    print("\n wifi_init.lua   zf191222.1825   \n")
    -- charge les secrets pour le wifi
    f= "secrets_wifi.lua"    if file.exists(f) then dofile(f) end

    wifi.setmode(wifi.STATION,true)
    wifi.sta.config{ssid=cli_ssid, pwd=cli_pwd, auto=true, save=true}
    wifi.sta.autoconnect(1)
    wifi.sta.connect()

    zLED=4   gpio.write(zLED, gpio.HIGH)   gpio.mode(zLED, gpio.OUTPUT)
    i=0
    wifi_init1=tmr.create()
    wifi_init1:alarm(1*1000, tmr.ALARM_AUTO , function()
        gpio.write(zLED, gpio.LOW)   tmr.delay(10000)   gpio.write(zLED, gpio.HIGH)
        if wifi.sta.getip() == nil then
            print("Connecting to AP...")
            i=i+1
            if i > 7 then
                wifi_init1:unregister()
                print("booum!")
                enduser_setup.start(function()
                    node.restart()
                end)
            end
        else
            wifi_init1:unregister()   zLED=nil
            f= "wifi_info.lua"   if file.exists(f) then dofile(f) end
            boot2_go = true
        end
    end)



end

wifi_init()
