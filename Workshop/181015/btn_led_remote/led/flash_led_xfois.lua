-- programme pour faire clignoter x fois une LED avec un rapport on/off
print("\n flash_led_xfois.lua zf181015.1641 \n")


zLED=0
zTm_On_LED = 100    --> en ms
zTm_Off_LED = 100    --> en ms
zFlag_LED = 0
zxfois = 0
zxfois_max =2

function blink_LED ()
    if zxfois > zxfois_max-1 then
        print(zxfois)
        tmr.stop(ztmr_LED)
        zFlag_LED=gpio.HIGH
    else 
        if zFlag_LED==gpio.LOW then
            zFlag_LED=gpio.HIGH
            tmr.alarm(ztmr_LED, zTm_Off_LED, tmr.ALARM_SINGLE, blink_LED)
        else 
            zFlag_LED=gpio.LOW
            tmr.alarm(ztmr_LED, zTm_On_LED, tmr.ALARM_SINGLE, blink_LED)
            zxfois = zxfois+1
        end
    end
        gpio.write(zLED, zFlag_LED)

end

gpio.mode(zLED, gpio.OUTPUT)
ztmr_LED = tmr.create()
blink_LED ()
