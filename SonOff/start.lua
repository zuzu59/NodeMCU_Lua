-- start.lua
-- programme de start
-- zf180715.2359

zBTN  = 3 -- GPIO0 button
zRelay = 6 -- GPIO12 PWM0 relay (active high)
zLED = 7 -- GPIO13 PWM1 GREEN LED (active low)

gpio.mode(zLED,gpio.OUTPUT)
pwm.setup(zLED, 2, 900)
pwm.start(zLED)
