-- Mesure la distance avec le module ultra-son de 15cm à 2m
-- Attention le module à ultra-son doit être alimenté en 5V !

print("\n 0_ultra_son.lua   zf200627.1846   \n")

speed_air = 382
zlength_min = 0.15
zlength_max = 0.62

zlength = (zlength_min+zlength_max)/2
zlength_1, zlength_2, zlength_3 = zlength,zlength,zlength

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
        if zlength>zlength_max then zlength=zlength_max end
        if zlength<zlength_min then zlength=zlength_min end
        
        zlength_3= zlength_2   zlength_2= zlength_1   zlength_1= zlength
        zlength = (zlength_1+zlength_2+zlength_3)/3
        
        disp_mesure()
    end
end

gpio.trig(zecho,"both",zmesure)

-- à commenter après les tests de calibration
function disp_mesure()  print("La distance est de "..zlength.."m")   end 

tmr_mesure=tmr.create()
tmr_mesure:alarm(1*1000, tmr.ALARM_AUTO, zmesure_pulse)

