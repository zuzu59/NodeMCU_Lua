-- programme pour faire un test depuis de le webide

function a2()
    print("\n a2.lua zf190617.1128 \n")
    
end

a2()

-- Lit les capteurs de température solaire et envoie les mesures sur ThingSpeak
-- zf190617.1134

-- lecture: https://thingspeak.com/channels/802784/private_show

-- source: https://nodemcu.readthedocs.io/en/master/modules/ds18b20/


local ow_pin = 3
ds18b20.setup(ow_pin)

print("toto182538")

    ztemp1=0    ztemp2=0    ztemp3=0

-- read all sensors and print all measurement results
ds18b20.read(
    function(ind,rom,res,temp,tdec,par)
--        print(ind,string.format("%02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X",string.match(rom,"(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%d+)")),res,temp,tdec,par)
        print(ind,temp)
        if ind == 1 then 
            ztemp1 = temp
--        elseif ind == 2 then
--            ztemp2 = temp
--        elseif ind == 3 then
--            ztemp3 = temp
            --C'est la fin de lecture, on envoie les mesures à ThingSpeak
            print(ztemp1,ztemp2,ztemp3)
            disp_send()
        end
    end,{})

print("tutu152603")

