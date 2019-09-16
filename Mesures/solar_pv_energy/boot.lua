-- Scripts à charger après le boot pour démarrer son appli

print("\n boot.lua zf190910.1342 \n")

function heartbeat()
    f= "flash_led_xfois.lua"   if file.exists(f) then dofile(f) end
    flash_led_xfois()
    boottimer1=tmr.create()
    boottimer1:alarm(1*1000,  tmr.ALARM_AUTO, function()
        xfois =2
        blink_LED ()
    end)
end

-- charge ses propres secrets
f= "secrets_energy.lua"    if file.exists(f) then dofile(f) end

--f= "led_rgb.lua"   if file.exists(f) then dofile(f) end
--f= "wifi_ap_start.lua"   if file.exists(f) then dofile(f) end
f= "wifi_ap_stop.lua"   if file.exists(f) then dofile(f) end
f= "wifi_cli_conf.lua"   if file.exists(f) then dofile(f) end
f= "wifi_cli_start.lua"   if file.exists(f) then dofile(f) end
f= "telnet_srv2.lua"   if file.exists(f) then dofile(f) end
f= "web_ide2.lua"   if file.exists(f) then dofile(f) end
f= "web_srv2.lua"   if file.exists(f) then dofile(f) end

--f= "0_get_energy.lua"   if file.exists(f) then dofile(f) end
--f= "0_send_temp.lua"   if file.exists(f) then dofile(f) end
--f= "0_cron_temp.lua"   if file.exists(f) then dofile(f) end

f=nil
--heartbeat=nil
heartbeat()



