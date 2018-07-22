--mesure la distance avec un module à ultra son hc-sr04
--Attention le module doit être alimenter en 5V et il faut mettre une resistance de 100 ohm sur la pin echo
--hv180713.1138

ztrig=5
zecho=6
ztstart=0
ztstop=0
gpio.mode(ztrig, gpio.OUTPUT)
gpio.write(ztrig, gpio.LOW)
gpio.mode(zecho, gpio.INT, gpio.PULLUP)


function zmesure_pulse()
    gpio.write(ztrig, gpio.HIGH)
    tmr.delay(10)
    gpio.write(ztrig, gpio.LOW)
end

function zmesure()
    if gpio.read(zecho)==1 then 
        ztstart=tmr.now()
    else
        ztstop=tmr.now() 
        zlength=360*(ztstop-ztstart)/2/10000
        print("distance [cm]: "..math.floor(zlength))
    end
end

gpio.trig(zecho, "both", zmesure)
tmr.alarm(1, 1000, tmr.ALARM_AUTO, zmesure_pulse)
