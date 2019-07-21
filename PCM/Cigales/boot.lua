-- Scripts à charger après le boot pour démarrer son appli

print("\n boot.lua zf190119.1933 \n")

function heartbeat()
    f= "flash_led_xfois.lua"   if file.exists(f) then dofile(f) end
    boottimer1=tmr.create()
    tmr.alarm(boottimer1, 1*1000,  tmr.ALARM_AUTO, function()
        xfois =2
        blink_LED ()
    end)
end

--f= "wifi_ap_start.lua"   if file.exists(f) then dofile(f) end
--f= "wifi_cli_conf.lua"   if file.exists(f) then dofile(f) end
--f= "wifi_cli_start.lua"   if file.exists(f) then dofile(f) end
--f= "telnet_srv2.lua"   if file.exists(f) then dofile(f) end
--f= "web_ide2.lua"   if file.exists(f) then dofile(f) end
--f= "web_srv.lua"   if file.exists(f) then dofile(f) end
--f= "set_time.lua"   if file.exists(f) then dofile(f) end
--f= "dsleep.lua"   if file.exists(f) then dofile(f) end
--f= "b.lua"   if file.exists(f) then dofile(f) end
f= "play_file.lua"   if file.exists(f) then dofile(f) end


--heartbeat()




