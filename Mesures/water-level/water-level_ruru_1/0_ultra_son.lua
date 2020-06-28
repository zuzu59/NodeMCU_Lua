-- Mesure la distance avec le module ultra-son de 15cm à 2m
-- Attention le module à ultra-son doit être alimenté en 5V !

print("\n 0_ultra_son.lua   zf200628.1448   \n")

speed_air = 382             -- en m/s
zlength_min = 12            -- en cm
zlength_max = 56            -- en cm

zlength_brut = 0
zlength = 9
zlength_1, zlength_2, zlength_3 = zlength,zlength,zlength

zlevel = 0

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
    gpio.serout(ztrig,gpio.HIGH,{3,1})
end

--Fonction pour mesurer la pulse
function zmesure()
    if fast_read(zecho)==1 then 
        ultra_son_start=tmr.now()
    else
        ultra_son_stop=tmr.now()
        -- print("Delta: "..ultra_son_stop-ultra_son_start)
        zlength_brut = math.floor(speed_air*(ultra_son_stop-ultra_son_start)/2/10000)
        if zlength_brut>zlength_max then zlength_brut = zlength end
        if zlength_brut<zlength_min then zlength_brut = zlength end

        zlength = zlength_brut
                
        zlength_3 = zlength_2   zlength_2 = zlength_1   zlength_1 = zlength
        zlength = math.floor((zlength_1+zlength_2+zlength_3)/3)
        
        zlevel = 100-math.floor((zlength-zlength_min)/(zlength_max-zlength_min)*100)
        
        if verbose then   print("Hauteur brute: "..zlength_brut.."cm, net: "..zlength.."cm , "..zlevel.."%")   end 
    end
end

gpio.trig(zecho,"both",zmesure)

tmr_mesure=tmr.create()
tmr_mesure:alarm(2*1000, tmr.ALARM_AUTO, zmesure_pulse)

