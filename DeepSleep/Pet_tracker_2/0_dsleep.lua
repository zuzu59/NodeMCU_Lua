-- Teste le deep sleep !
-- s'endore pendant xx secondes après xx secondes

-- ATTENTION: il faut connecter la pin 0 à la pin RESET avec une résistance de 1k !

print("\n dsleep.lua   zf200722.0933   \n")

f= "flash_led_xfois.lua"   if file.exists(f) then dofile(f) end

function dsleep_on()
    print("timer dsleep on...")
    ztmr_SLEEP = tmr.create()
    ztmr_SLEEP:alarm(5*1000, tmr.ALARM_SINGLE, function ()
        print("Je dors...")
        tmr.delay(100*1000)
--        node.dsleep(4*1000*1000)
        rtctime.dsleep(10*1000*1000,4)
    end)
end

function dsleep_off()
    print("timer dsleep off...")
    ztmr_SLEEP:unregister()
end

function watch_wifi_on()
    dsleep_on()
    ztmr_watch_wifi_on = tmr.create()
    ztmr_watch_wifi_on:alarm(1*1000, tmr.ALARM_AUTO , function()
        if wifi.sta.getip() == nil then
--            print("Unconnected... (on)")
        else
            ztmr_watch_wifi_on:stop()
            print("Connected... (on)")
--            f= "wifi_info.lua"   if file.exists(f) then dofile(f) end
            watch_wifi_off()
        end
    end)
end

function watch_wifi_off()
    dsleep_off()
    ztmr_watch_wifi_on:unregister()
    ztmr_watch_wifi_off = tmr.create()
    ztmr_watch_wifi_off:alarm(1*1000, tmr.ALARM_AUTO , function()
        if wifi.sta.getip() == nil then
            ztmr_watch_wifi_off:stop()
            print("Unconnected... (off)")
            watch_wifi_on()
            ztmr_watch_wifi_off:unregister()
        else
--            print("Connected... (off)")
            xfois = 2
            blink_LED ()
        end
    end)
end

print("Coucou, je suis réveillé...")
print("Et il est: ")
ztime()

watch_wifi_on()

