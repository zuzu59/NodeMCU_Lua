-- programme pour faire clignoter une LED version simplifiée

print("\n blink_led2.lua zf200203.1823 \n")

zLED=0
gpio.mode(zLED, gpio.OUTPUT)
ztmr_LED = tmr.create()
value = true

ztmr_LED:alarm(100, tmr.ALARM_AUTO, function ()
    if value then
        gpio.write(zLED, gpio.HIGH)
    else
        gpio.write(zLED, gpio.LOW)
    end
    value = not value
end)
