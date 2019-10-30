-- Petit script pour initaliser une fois la couche WIFI

function wifi_init()
    print("\n wifi_init.lua   zf191030.1358   \n")
    -- charge les secrets pour lw wifi
    f= "secrets_wifi.lua"    if file.exists(f) then dofile(f) end
    
    f= "wifi_ap_start.lua"   if file.exists(f) then dofile(f) end
    --f= "wifi_ap_stop.lua"   if file.exists(f) then dofile(f) end
    f= "wifi_cli_start.lua"   if file.exists(f) then dofile(f) end
    f= "wifi_cli_conf.lua"   if file.exists(f) then dofile(f) end
    --f= "wifi_cli_stop.lua"   if file.exists(f) then dofile(f) end
    
end

wifi_init()
--wifi_init=nil   cli_ssid=nil   cli_pwd=nil

--[[
wifi.setmode(wifi.STATIONAP,save)
print(wifi.getdefaultmode())
print(wifi.getmode())


]]
