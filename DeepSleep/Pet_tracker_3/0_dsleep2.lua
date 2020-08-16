-- Script de gestion du deep sleep !
-- ATTENTION: il faut connecter la pin 0 à la pin RESET avec une résistance de 1k !

print("\n 0_dsleep2.lua   zf200816.1934   \n")

f= "flash_led_xfois.lua"   if file.exists(f) then dofile(f) end

function ztime()
    tm = rtctime.epoch2cal(rtctime.get()+2*3600)
    return (string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"], tm["day"], tm["hour"], tm["min"], tm["sec"]))
end

-- on s'endort
function dsleep_on()
    print("Il est "..ztime().." et je vais dormir...")
    tmr.delay(100*1000)
    wifi.setmode(wifi.NULLMODE,true)
    -- durée du sommeil !
    rtctime.dsleep(0.1*1000*1000)
end

-- on se réveil
function dsleep_wake_up()
    print("Coucou, je suis réveillé... et il est "..ztime())
    if rtctime.get() < 1597494477 then
        print("oups je n'ai pas la bonne heure...")
        rtctime.set(file.getcontents("_ztime_"))
        print("voilà j'ai retrouvé une ancienne heure "..ztime())
    end
    wifi.setmode(wifi.STATION)
    f = "0_wifi_scan.lua"   if file.exists(f) then dofile(f) end
end

dsleep_wake_up()
