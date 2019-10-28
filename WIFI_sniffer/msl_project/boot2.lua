-- Scripts à charger après le boot pour démarrer son appli

print("\n boot2.lua zf191020.1840 \n")

second_chance=nil
function heartbeat()
    f= "flash_led_xfois.lua"   if file.exists(f) then dofile(f) end
    flash_led_xfois()
    boottimer1=tmr.create()
    boottimer1:alarm(1*1000,  tmr.ALARM_AUTO, function()
        xfois =2
        blink_LED ()
    end)
end

--f= "0_get_data.lua"   if file.exists(f) then dofile(f) end
--f= "0_send_data.lua"   if file.exists(f) then dofile(f) end
--f= "0_cron.lua"   if file.exists(f) then dofile(f) end

f=nil
--heartbeat=nil
heartbeat()
