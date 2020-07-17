-- Scripts à charger au moment du boot
print("\n start_boot.lua   zf200717.1647   \n")

zLED=4  gpio.write(zLED, gpio.HIGH)  gpio.mode(zLED,gpio.OUTPUT)

gpio.write(zLED, gpio.LOW)   tmr.delay(10000)   gpio.write(zLED, gpio.HIGH)

dofile("wifi_cli_start.lua")
dofile("web_cli.lua")
dofile("btn_led.lua")

gpio.write(zLED, gpio.LOW)   tmr.delay(10000)   gpio.write(zLED, gpio.HIGH)

