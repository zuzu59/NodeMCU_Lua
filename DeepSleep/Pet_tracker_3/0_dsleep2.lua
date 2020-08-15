-- Teste le deep sleep !
-- s'endore pendant xx secondes après xx secondes

-- ATTENTION: il faut connecter la pin 0 à la pin RESET avec une résistance de 1k !

print("\n dsleep2.lua   zf200815.1430   \n")

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
        -- rtcmem.write32(10, 43690)       --flag pour détecter le réveil dsleep au moment du boot
        -- print("le flag est à "..rtcmem.read32(10))
        wifi.setmode(wifi.NULLMODE,true)
        rtctime.dsleep(0.1*1000*1000)
    -- end)
end


-- on se réveil, vérifie si on peut avoir du réseau autrement on va redormir
function dsleep_wake_up()
    print("Coucou, je suis réveillé... et il est "..ztime())
    if rtctime.get() < 1597494477 then
        print("oups je n'ai pas la bonne heure...")
        rtctime.set(file.getcontents("_ztime_"))
        print("voilà j'ai retrouvé une ancienne heure "..ztime())

    end
    if wifi.sta.getip() == nil then
        print("Pas de réseau donc je scan le wifi...")
        f = "0_wifi_scan.lua"   if file.exists(f) then dofile(f) end
        wifi.setmode(wifi.STATION)
        scan_wifi()
    else
        print("Y'a du réseau donc je m'arrête...")
    end
end


dsleep_wake_up()
