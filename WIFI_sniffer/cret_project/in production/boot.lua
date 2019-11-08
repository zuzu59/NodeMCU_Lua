-- Scripts à charger après le boot pour démarrer le core system

print("\n boot.lua zf191029.2257 \n")


--f= "led_rgb.lua"   if file.exists(f) then dofile(f) end
f= "telnet_srv2.lua"   if file.exists(f) then dofile(f) end
--f= "web_ide2.lua"   if file.exists(f) then dofile(f) end
--ff= "web_srv2.lua"   if file.exists(f) then dofile(f) end

