--Petit script pour la gestion de la LED, juste pour comprendre la prog ;-)

print("\n led_job.lua   zf181018.1616   \n")

zLED=0
gpio.mode(zLED, gpio.OUTPUT)
gpio.write(zLED, gpio.HIGH)

function led_on()
    gpio.write(zLED, gpio.LOW)
    fled="ON"
end

function led_off()
    gpio.write(zLED, gpio.HIGH)
    fled="ON"
end

led_on()
led_off()

