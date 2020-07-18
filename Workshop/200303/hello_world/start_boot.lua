-- Scripts à charger au moment du boot
print("\n start_boot.lua   zf200718.1208   \n")

zLED=4  gpio.write(zLED, gpio.HIGH)  gpio.mode(zLED,gpio.OUTPUT)

gpio.write(zLED, gpio.LOW)   tmr.delay(10000)   gpio.write(zLED, gpio.HIGH)

dofile("blink_led1.lua")

gpio.write(zLED, gpio.LOW)   tmr.delay(10000)   gpio.write(zLED, gpio.HIGH)


