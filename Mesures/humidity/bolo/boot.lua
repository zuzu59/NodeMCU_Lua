-- Scripts à charger après le boot pour démarrer le core system

print("\n boot.lua zf191221.1509 \n")

function boot()
    gpio.trig(zswitch, "none")   hvbouton=nil   zswitch=nil   reset_reason=nil

    f= "telnet_srv2.lua"   if file.exists(f) then dofile(f) end
    f= "wifi_init.lua"   if file.exists(f) then dofile(f) end
end
boot()
