zBTN  = 3 -- GPIO0 button
zRelay = 6 -- GPIO12 PWM0 relay (active high)
zLED = 7 -- GPIO13 PWM1 GREEN LED (active low)

--pwm.setup(zLED, 1, 500)
--pwm.start(zLED)

gpio.mode(zBTN,gpio.INT)
pwm.stop(zLED)
gpio.write(zLED,1)

gpio.trig(zBTN, "both",function() 
    if gpio.read(zBTN)==0 then
        pwm.stop(zLED)
        gpio.write(zLED,0)
        t1=tmr.now()
    else
        gpio.write(zLED,1)
        t2=tmr.now()
        t3=(t2-t1)/1000000
        print(t3)
        if t3<2 then
            gpio.write(zLED,1)
            print("start")
            pwm.setup(zLED, 1, 500)
            pwm.start(zLED)
        else
            print("config")
            pwm.setup(zLED, 10, 500)
            pwm.start(zLED)
        end
           
    end
end)
