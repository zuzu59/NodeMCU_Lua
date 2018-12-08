-- Teste le deep sleep !
-- s'endore pendant xx secondes après xx secondes

-- ATTENTION: il faut connecter la pin 0 à la pin RESET avec une résistance de 1k !

print("\n dsleep.lua   zf181208.1858   \n")

f= "flash_led_xfois.lua"   if file.exists(f) then dofile(f) end

function dsleep_on()
    print("timer dsleep on...")
    ztmr_SLEEP = tmr.create()
    tmr.alarm(ztmr_SLEEP, 10*1000, tmr.ALARM_SINGLE, function ()
        print("Je dors...")
        node.dsleep(10*1000*1000)
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

_, reset_reason = node.bootreason()
print("reset_reason: ",reset_reason)
if reset_reason == 4 then print("Coucou, soft reset...") end
if reset_reason == 5 then print("Coucou, je suis réveillé...") end
if reset_reason == 6 then print("Coucou, hard reset...") end

watch_wifi_on()

