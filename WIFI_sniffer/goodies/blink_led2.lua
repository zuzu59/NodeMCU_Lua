-- programme pour faire clignoter une LED version simplifiée
-- ATTENTION, cela utilise la pin4 pour la LED des module ESP-M3 !

print("\n blink_led2.lua zf181208.146 \n")

zLED=4
gpio.mode(zLED, gpio.OUTPUT)
ztmr_LED = tmr.create()
value = true

tmr.alarm(ztmr_LED, 100, tmr.ALARM_AUTO, function ()
    if value then
        gpio.write(zLED, gpio.HIGH)
    else
        gpio.write(zLED, gpio.LOW)
    end
    value = not value
end)
