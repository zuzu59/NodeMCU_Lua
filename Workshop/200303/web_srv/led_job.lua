--Petit script pour la gestion de la LED, juste pour comprendre la prog ;-)

print("\n led_job.lua   zf200717.1746   \n")

zLED=4   gpio.mode(zLED, gpio.OUTPUT)   gpio.write(zLED, gpio.HIGH)

function led_on()
    gpio.write(zLED, gpio.LOW)
    fled="ON"
end

function led_off()
    gpio.write(zLED, gpio.HIGH)
    fled="ON"
end

led_on()   tmr.delay(10000)   led_off()

