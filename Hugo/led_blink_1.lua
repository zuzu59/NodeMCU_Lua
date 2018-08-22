-- programme pour faire clignoter un LED
--hv20180711.1007

zpin=1
valeur=gpio.HIGH
duration = 300    --> en ms


function clignoter ()
    if valeur==gpio.LOW then 
        valeur=gpio.HIGH
    else 
        valeur=gpio.LOW
    end
    gpio.write(zpin, valeur)
end


gpio.mode(zpin, gpio.OUTPUT)
gpio.write(zpin, valeur)

tmr.alarm(0,duration, tmr.ALARM_AUTO, clignoter)

