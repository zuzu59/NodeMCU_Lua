-- programme pour faire clignoter x fois une LED avec un rapport on/off
print("\n flash_led_xfois.lua zf200717.1748 \n")

zLED=4
zTm_On_LED = 50    --> en ms
zTm_Off_LED = 100    --> en ms
nbfois = 0
gpio.write(zLED, gpio.HIGH)   gpio.mode(zLED, gpio.OUTPUT)
ztmr_LED = tmr.create()

function blink_LED ()
    if nbfois >= xfois then
        print(nbfois)
        nbfois = 0
    else 
        if gpio.read(zLED) == gpio.HIGH then
            gpio.write(zLED, gpio.LOW)
            ztmr_LED:alarm(zTm_Off_LED, tmr.ALARM_SINGLE, blink_LED)
        else 
            gpio.write(zLED, gpio.HIGH)
            nbfois = nbfois+1
            ztmr_LED:alarm(zTm_On_LED, tmr.ALARM_SINGLE, blink_LED)
        end
    end
end

xfois =2
blink_LED ()



