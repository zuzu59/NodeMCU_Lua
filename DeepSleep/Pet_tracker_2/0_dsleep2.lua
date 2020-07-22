-- Teste le deep sleep !
-- s'endore pendant xx secondes après xx secondes

-- ATTENTION: il faut connecter la pin 0 à la pin RESET avec une résistance de 1k !

print("\n dsleep.lua   zf200722.1546   \n")

zLED=4
f= "flash_led_xfois.lua"   if file.exists(f) then dofile(f) end

function ztime()
    tm = rtctime.epoch2cal(rtctime.get()+2*3600)
    return (string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"], tm["day"], tm["hour"], tm["min"], tm["sec"]))
end

function dsleep_on()
    print("timer dsleep on...")
    -- ztmr_SLEEP = tmr.create()
    -- ztmr_SLEEP:alarm(2*1000, tmr.ALARM_SINGLE, function ()
        print("Il est "..ztime().." et je vais dormir...")
        tmr.delay(100*1000)
        -- node.dsleep(4*1000*1000)
        -- print(node.bootreason())
        rtcmem.write32(10, 43690)       --flag pour détecter le réveil dsleep au moment du boot
        -- print("le flag est à "..rtcmem.read32(10))
        wifi.setmode(wifi.NULLMODE,true)
        rtctime.dsleep(4*1000*1000)
    -- end)
end

--[[
dsleep_on()
print(node.bootreason())
print("le flag est à "..rtcmem.read32(10))

f= "wifi_info.lua"   if file.exists(f) then dofile(f) end

function ztime()
    tm = rtctime.epoch2cal(rtctime.get()+2*3600)
    print(string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"], tm["day"], tm["hour"], tm["min"], tm["sec"]))
end

print(ztime())


]]

-- on se réveil, vérifie si on peut avoir du réseau autrement on va redormir
function dsleep_wake_up()
    print("Coucou, je suis réveillé... et il est "..ztime())

end



-- function dsleep_off()
--     print("timer dsleep off...")
--     ztmr_SLEEP:unregister()
-- end

-- function watch_wifi_on()
--     dsleep_on()
--     ztmr_watch_wifi_on = tmr.create()
--     ztmr_watch_wifi_on:alarm(1*1000, tmr.ALARM_AUTO , function()
--         if wifi.sta.getip() == nil then
-- --            print("Unconnected... (on)")
--         else
--             ztmr_watch_wifi_on:stop()
--             print("Connected... (on)")
-- --            f= "wifi_info.lua"   if file.exists(f) then dofile(f) end
--             watch_wifi_off()
--         end
--     end)
-- end

-- function watch_wifi_off()
--     dsleep_off()
--     ztmr_watch_wifi_on:unregister()
--     ztmr_watch_wifi_off = tmr.create()
--     ztmr_watch_wifi_off:alarm(1*1000, tmr.ALARM_AUTO , function()
--         if wifi.sta.getip() == nil then
--             ztmr_watch_wifi_off:stop()
--             print("Unconnected... (off)")
--             watch_wifi_on()
--             ztmr_watch_wifi_off:unregister()
--         else
-- --            print("Connected... (off)")
--             xfois = 2
--             blink_LED ()
--         end
--     end)
-- end

-- watch_wifi_on()

dsleep_wake_up()
