-- Teste le deep sleep !
-- s'endore pendant xx secondes après xx secondes

-- ATTENTION: il faut connecter la pin 0 à la pin RESET avec une résistance de 1k !

print("\n dsleep.lua   zf181211.0018   \n")

f= "flash_led_xfois.lua"   if file.exists(f) then dofile(f) end

function dsleep_on()
    print("timer dsleep on...")
    ztmr_SLEEP = tmr.create()
    tmr.alarm(ztmr_SLEEP, 10*1000, tmr.ALARM_SINGLE, function ()
        print("Je dors...")
        tmr.delay(100*1000)
--        node.dsleep(4*1000*1000)
        rtctime.dsleep(30*1000*1000)
    end)
end

function dsleep_off()
    print("timer dsleep off...")
    tmr.unregister(ztmr_SLEEP)
end

function watch_wifi_on()
    dsleep_on()
    ztmr_watch_wifi_on=tmr.create()
    tmr.alarm(ztmr_watch_wifi_on, 1000, tmr.ALARM_AUTO , function()
        if wifi.sta.getip() == nil then
--            print("Unconnected... (on)")
        else
            tmr.stop(ztmr_watch_wifi_on)
            print("Connected... (on)")
--            f= "wifi_info.lua"   if file.exists(f) then dofile(f) end
            watch_wifi_off()
        end
    end)
end

function watch_wifi_off()
    dsleep_off()
    tmr.unregister(ztmr_watch_wifi_on)
    ztmr_watch_wifi_off=tmr.create()
    tmr.alarm(ztmr_watch_wifi_off, 1000, tmr.ALARM_AUTO , function()
        if wifi.sta.getip() == nil then
            tmr.stop(ztmr_watch_wifi_off)
            print("Unconnected... (off)")
            watch_wifi_on()
            tmr.unregister(ztmr_watch_wifi_off)
        else
--            print("Connected... (off)")
            xfois =2
            blink_LED ()
        end
    end)
end

print("Coucou, je suis réveillé...")
print("Et il est: ")
ztime()

watch_wifi_on()

