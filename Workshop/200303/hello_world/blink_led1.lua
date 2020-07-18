-- programme pour faire clignoter une LED version simplifiée

print("\n blink_led1.lua   zf200718.1204   \n")

zLED=4
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
