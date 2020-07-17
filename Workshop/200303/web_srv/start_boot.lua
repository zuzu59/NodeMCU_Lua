-- Scripts à charger au moment du boot
print("\n start_boot.lua   zf200717.1749   \n")

zLED=4  gpio.write(zLED, gpio.HIGH)  gpio.mode(zLED,gpio.OUTPUT)

gpio.write(zLED, gpio.LOW)   tmr.delay(10000)   gpio.write(zLED, gpio.HIGH)

dofile("wifi_ap_start.lua")
dofile("led_job.lua")
dofile("web_srv.lua")
dofile("flash_led_xfois.lua")

gpio.write(zLED, gpio.LOW)   tmr.delay(10000)   gpio.write(zLED, gpio.HIGH)


