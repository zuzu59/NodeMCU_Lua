-- Scripts pour régler l'horloge quand on est connecté en WIFI

print("\n set_time.lua zf181211.0010 \n")

--f= "wifi_ap_stop.lua"   if file.exists(f) then dofile(f) end
--f= "wifi_cli_conf.lua"   if file.exists(f) then dofile(f) end
--f= "wifi_cli_start.lua"   if file.exists(f) then dofile(f) end
--f= "telnet_srv.lua"   if file.exists(f) then dofile(f) end
--f= "web_ide2.lua"   if file.exists(f) then dofile(f) end
--f= "dsleep.lua"   if file.exists(f) then dofile(f) end



function set_time()
    sntp.sync(nil, nil, nil, 1)
end

function ztime()
    tm = rtctime.epoch2cal(rtctime.get())
    print(string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"], tm["day"], tm["hour"], tm["min"], tm["sec"]))
end

set_time()

