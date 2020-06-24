-- Mesure la distance avec le module ultra-son de 15cm à 2m
-- Attention le module à ultra-son doit être alimenté en 5V !

print("\n 0_ultra_son.lua   zf200624.2011   \n")

speed_air=382

--Paramètres pour le module ultra son
local ztrig=5
gpio.mode(ztrig, gpio.OUTPUT)
local fast_write = gpio.write
fast_write(ztrig, 0)

local zecho=6
gpio.mode(zecho, gpio.INT, gpio.PULLUP)
local fast_read = gpio.read

local ultra_son_start, ultra_son_stop = 0,0

--Function pour envoyer la pulse
function zmesure_pulse()
    gpio.serout(ztrig,gpio.HIGH,{10,1})
end

--Fonction pour mesurer la pulse
function zmesure()
    if fast_read(zecho)==1 then 
        ultra_son_start=tmr.now()
    else
        ultra_son_stop=tmr.now()
        -- print("Delta: "..ultra_son_stop-ultra_son_start)
        zlength=math.floor(speed_air*(ultra_son_stop-ultra_son_start)/2/10000)/100
        --zlength=speed_air*(ultra_son_stop-ultra_son_start)/2/10000
        if zlength>2 then zlength=2 end
        if zlength<0.15 then zlength=0.15 end
        
        disp_mesure()
    end
end

gpio.trig(zecho,"both",zmesure)

-- à commenter après les tests de calibration
function disp_mesure()  print("La distance est de "..zlength.."m")   end 

tmr_mesure=tmr.create()
tmr_mesure:alarm(1*1000, tmr.ALARM_AUTO, zmesure_pulse)

