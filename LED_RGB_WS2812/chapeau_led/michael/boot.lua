-- Scripts � charger apr�s le boot pour d�marrer son appli

print("\n boot.lua 07.12.18 1634\n")
f= "wifi_ap_stop.lua"   if file.exists(f) then dofile(f) end
f= "wifi_cli_conf.lua"   if file.exists(f) then dofile(f) end
f= "wifi_cli_start.lua"   if file.exists(f) then dofile(f) end
f= "web_ide2.lua"   if file.exists(f) then dofile(f) end
f= "az_init_led.lua"   if file.exists(f) then dofile(f) end
f= "webleds.lua"   if file.exists(f) then dofile(f) end
f= "test.lua"   if file.exists(f) then dofile(f) end
