-- Mesure la distance avec le module ultra-son
print("\n ultra_son.lua   zf181026.1355   \n")

--Parametres pour le module ultra son 
local ztrig=5
gpio.mode(ztrig, gpio.OUTPUT)
local fast_write = gpio.write
fast_write(ztrig, 0)

local zecho=6
gpio.mode(zecho, gpio.INT, gpio.PULLUP)
detectortimer1=tmr.create() 
detectortimer2=tmr.create()
local fast_read = gpio.read

local ultra_son_start=0
local ultra_son_stop=0

--Function pour envoyer la pulse
function zmesure_pulse()
--t1=tmr.now()
    fast_write(ztrig, 1)
    fast_write(ztrig, 0)
--t2=tmr.now()
--print("durée: "..t2-t1-314)
end

--Fonction pour mesurer la pulse
function zmesure()
--print("pin: "..gpio.read(zecho))
    if fast_read(zecho)==1 then 
        ultra_son_start=tmr.now()
    else
        ultra_son_stop=tmr.now()
print("Delta: "..ultra_son_stop-ultra_son_start)
--        zlength=math.floor(480*(ultra_son_stop-ultra_son_start)/2/10000)/100
        zlength=480*(ultra_son_stop-ultra_son_start)/2/10000
--        if zlength>6 then zlength=0 end
        disp_mesure()
    end
end

gpio.trig(zecho,"both",zmesure)



-- à commenter après les tests de perf
function disp_mesure()  print(zlength)   end 
tmr.alarm(detectortimer1, 1000, tmr.ALARM_AUTO, zmesure_pulse)

