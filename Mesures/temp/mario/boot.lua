-- Scripts à charger après le boot pour démarrer le core system

print("\n boot.lua zf191124.1920 \n")

function boot()
    --f= "led_rgb.lua"   if file.exists(f) then dofile(f) end
    f= "telnet_srv2.lua"   if file.exists(f) then dofile(f) end
    f= "wifi_init.lua"   if file.exists(f) then dofile(f) end
    --f= "web_ide2.lua"   if file.exists(f) then dofile(f) end
    --f= "web_srv2.lua"   if file.exists(f) then dofile(f) end
end
boot()

