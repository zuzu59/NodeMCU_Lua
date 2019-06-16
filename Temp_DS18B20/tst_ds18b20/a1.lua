-- programme pour faire un test depuis de le webide

-- source: https://nodemcu.readthedocs.io/en/master/modules/ds18b20/

function a1()
    print("\n a1.lua zf190616.1519 \n")
end

a1()

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
        elseif ind == 2 then
            ztemp2 = temp
        elseif ind == 3 then
            ztemp3 = temp
            --C'est la fin de lecture, on envoie les mesures à ThingSpeak
            print(ztemp1,ztemp2,ztemp3)
            disp_send()
        end
    end,{})

print("tutu152603")

