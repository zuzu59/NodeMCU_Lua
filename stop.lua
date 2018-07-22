-- stop.lua
-- programme de stop
-- zf180716.0010

zBTN  = 3 -- GPIO0 button
zRelay = 6 -- GPIO12 PWM0 relay (active high)
zLED = 7 -- GPIO13 PWM1 GREEN LED (active low)

gpio.mode(zLED,gpio.OUTPUT)
pwm.stop(zLED)
gpio.write(zLED,1)


