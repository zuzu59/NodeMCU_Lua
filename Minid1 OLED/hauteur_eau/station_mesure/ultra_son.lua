-- Mesure la distance avec le module ultra-son
print("\n ultra_son.lua   zf180826.1837   \n")


--Parametres pour le module ultra son 
ztrig=5
zecho=6
zlength=0
gpio.mode(ztrig, gpio.OUTPUT)
gpio.write(ztrig, gpio.LOW)
gpio.mode(zecho, gpio.INT, gpio.PULLUP)
detectortimer1=tmr.create() 
detectortimer2=tmr.create()

--Function pour faire envoyer la pulse
function zmesure_pulse()
    gpio.write(ztrig, gpio.HIGH)
    tmr.delay(10)
    gpio.write(ztrig, gpio.LOW)
end

--Fonction pour mesurer la pulse
function zmesure()
    if gpio.read(zecho)==1 then 
        ultra_son_start=tmr.now()
    else
        ultra_son_stop=tmr.now()
        zlength=math.floor(360*(ultra_son_stop-ultra_son_start)/2/10000)/100
        if zlength>6 then zlength=0 end
        disp_mesure()
--        print(zlength)
    end

end

gpio.trig(zecho,"both",zmesure)
--tmr.alarm(detectortimer1, 1000, tmr.ALARM_AUTO, zmesure_pulse)

