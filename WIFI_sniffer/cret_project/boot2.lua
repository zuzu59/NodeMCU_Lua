-- Scripts à charger après le boot pour démarrer son projet

print("\n boot2.lua zf191029.2154 \n")

second_chance=nil

f= "flash_led_xfois.lua"   if file.exists(f) then dofile(f) end
xfois =5   blink_LED ()

function heartbeat()
    boottimer1=tmr.create()
    boottimer1:alarm(1*1000,  tmr.ALARM_AUTO, function()
        xfois =2
        blink_LED ()
    end)
end

-- charge ses propres secrets
f= "secrets_project.lua"    if file.exists(f) then dofile(f) end

f= "set_time.lua"   if file.exists(f) then dofile(f) end



f=nil

tmr.create():alarm(4*1000,  tmr.ALARM_SINGLE, function()
    flash_led_xfois=nil   blink_LED=nil   ztmr_Flash_LED=nil
    zTm_Off_LED=nil  zTm_On_LED=nil  nbfois=nil  xfois=nil  zLED=nil
end)

heartbeat=nil
--heartbeat()

--[[
for k,v in pairs(_G) do print(k,v) end


]]

