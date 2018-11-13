-- programme pour faire des ping en permanence

print("\n make_ping.lua zf181113.1947 \n")

zLED=0
gpio.mode(zLED, gpio.OUTPUT)
ztmr_LED = tmr.create()
value = true

dofile("ping.lua")

tmr.alarm(ztmr_LED, 500, tmr.ALARM_AUTO, function ()
    if value then
        gpio.write(zLED, gpio.HIGH)
    else
        gpio.write(zLED, gpio.LOW)
        Ping("192.168.0.102")
    end
    value = not value
end)
