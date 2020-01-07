-- Scripts à charger après le boot pour démarrer le core system

print("\n boot.lua zf200107.1443 \n")

function boot()


        initalarme2=tmr.create()
        initalarme2:alarm(30*1000,  tmr.ALARM_SINGLE, function()
            f= "boot2.lua"   if file.exists(f) then dofile(f) end
        end)



    if zswitch ~= nill then
        gpio.trig(zswitch, "none")   hvbouton=nil   zswitch=nil   reset_reason=nil
    end
    f= "wifi_init.lua"   if file.exists(f) then dofile(f) end
    f= "telnet_srv2.lua"   if file.exists(f) then dofile(f) end
    f= "web_srv2.lua"   if file.exists(f) then dofile(f) end
    second_chance=nil   initz=nil   f=nil   boot=nil
end
boot()
