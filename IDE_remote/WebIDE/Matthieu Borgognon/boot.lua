-- Scripts à charger après le boot pour démarrer le core system

print("\n boot.lua zf191020.1318 \n")

-- charge ses propres secrets
f= "secrets_energy.lua"    if file.exists(f) then dofile(f) end

--f= "led_rgb.lua"   if file.exists(f) then dofile(f) end
--f= "wifi_ap_start.lua"   if file.exists(f) then dofile(f) end
f= "wifi_ap_stop.lua"   if file.exists(f) then dofile(f) end
f= "wifi_cli_conf.lua"   if file.exists(f) then dofile(f) end
f= "wifi_cli_start.lua"   if file.exists(f) then dofile(f) end
--f= "telnet_srv2.lua"   if file.exists(f) then dofile(f) end
--f= "web_ide2.lua"   if file.exists(f) then dofile(f) end
--f= "web_srv2.lua"   if file.exists(f) then dofile(f) end
