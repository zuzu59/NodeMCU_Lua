-- programme pour faire clignoter une LED avec un rapport on/off

print("\n blink_led1.lua zf181116.0014 \n")

zLED=0
zTm_On_LED = 50    --> en ms
zTm_Off_LED = 500    --> en ms
zFlag_LED = 0

function blink_LED ()
    if zFlag_LED==gpio.LOW then 
        zFlag_LED=gpio.HIGH
        tmr.alarm(ztmr_LED, zTm_Off_LED, tmr.ALARM_SINGLE, blink_LED)
    else 
        zFlag_LED=gpio.LOW
        tmr.alarm(ztmr_LED, zTm_On_LED, tmr.ALARM_SINGLE, blink_LED)
    end
    gpio.write(zLED, zFlag_LED)
end

gpio.mode(zLED, gpio.OUTPUT)
ztmr_LED = tmr.create()
blink_LED ()
