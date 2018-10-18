-- Exemple de programme à ne PAS faire sur NodeMCU Lua script
-- programme pour faire clignoter une LED avec un rapport on/off
--zf20181004.1430

zLED=0
gpio.mode(zLED, gpio.OUTPUT)

while true do
    gpio.write(zLED, 0)
    tmr.delay(1000*500)
    gpio.write(zLED, 1)
    tmr.delay(1000*500)
end
