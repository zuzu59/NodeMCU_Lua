-- programme pour faire clignoter deux LED
--hv20180711.1008

zpin1=1
zpin2=2

valeur1=gpio.HIGH
valeur2=gpio.HIGH

duration1 = 300    --> en ms
duration2 = 1000    --> en ms


function LED1 ()
    if valeur1==gpio.LOW then 
        valeur1=gpio.HIGH
    else 
        valeur1=gpio.LOW
    end
    gpio.write(zpin1, valeur1)
end

function LED2 ()
    if valeur2==gpio.LOW then 
        valeur2=gpio.HIGH
    else 
        valeur2=gpio.LOW
    end
    gpio.write(zpin2, valeur2)
end


gpio.mode(zpin1, gpio.OUTPUT)
gpio.write(zpin1, valeur1)
gpio.mode(zpin2, gpio.OUTPUT)
gpio.write(zpin2, valeur2)

tmr.alarm(1, duration1, tmr.ALARM_AUTO, LED1)
tmr.alarm(2, duration2, tmr.ALARM_AUTO, LED2)
