-- Scripts de seconde chance pour réparer une boucle dans le restart

print("\n repair.lua zf181119.2356 \n")

--f= "wifi_ap_start.lua"   if file.exists(f) then dofile(f) end
--f= "telnet_srv.lua"   if file.exists(f) then dofile(f) end

f= "az_init_led.lua"   if file.exists(f) then dofile(f) end


--[[
jobtimer1=tmr.create()
tmr.alarm(jobtimer1, 5*1000,  tmr.ALARM_AUTO, function()
    print("repair...")
end)
]]