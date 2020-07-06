-- Mesure la distance avec le module ultra-son de 15cm à 2m
-- Attention le module à ultra-son doit être alimenté en 5V !

print("\n 0_ultra_son.lua   zf200706.1710   \n")

speed_air = 382             -- en m/s
zlength_min = 12            -- en cm
zlength_max = 56            -- en cm

zlength_brut = 0
zlength = 33
zlength_1, zlength_2, zlength_3 = zlength,zlength,zlength
znbmaxerr = 0
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
        -- zlength_brut = math.floor(speed_air*(ultra_son_stop-ultra_son_start)/2/10000)
        zlength_brut = (speed_air*(ultra_son_stop-ultra_son_start)/2/10000)

        
        zmes="bolo_ruru,capteur="..node_id.." hauteur_brute="..zlength_brut
        http_post(influxdb_url,zmes)
        

        -- if (zlength_brut>=4) and (zlength_brut<=65) then zlength = zlength_brut end
        if (math.abs(zlength_brut-zlength) < 3) or (znbmaxerr > 2) then
            zlength = zlength_brut
            znbmaxerr = 0
        else
            znbmaxerr = znbmaxerr + 1
        end
            
        zmes="bolo_ruru,capteur="..node_id.." hauteur_brute2="..zlength
        http_post(influxdb_url,zmes)
                
        zlength_3 = zlength_2   zlength_2 = zlength_1   zlength_1 = zlength
        -- zlength = math.floor((zlength_1+zlength_2+zlength_3)/3)
        zlength = ((zlength_1+zlength_2+zlength_3)/3)
        
        zlevel = 100-math.floor((zlength-zlength_min)/(zlength_max-zlength_min)*100)
        
        if verbose then   print("Hauteur brute: "..zlength_brut.."cm, net: "..zlength.."cm , "..zlevel.."%")   end 
    end
end

gpio.trig(zecho,"both",zmesure)

tmr_mesure=tmr.create()
tmr_mesure:alarm(5*1000, tmr.ALARM_AUTO, zmesure_pulse)
zmesure_pulse()

