-- Scripts à charger après le boot pour démarrer son appli

print("\n boot.lua zf181125.1635 \n")

--f= "wifi_ap_stop.lua"   if file.exists(f) then dofile(f) end
--f= "wifi_cli_conf.lua"   if file.exists(f) then dofile(f) end
--f= "wifi_cli_start.lua"   if file.exists(f) then dofile(f) end
--f= "telnet_srv.lua"   if file.exists(f) then dofile(f) end
--f= "web_ide2.lua"   if file.exists(f) then dofile(f) end
--f= "dsleep.lua"   if file.exists(f) then dofile(f) end

f= "a_test_train.lua"   if file.exists(f) then dofile(f) end
--f= "a_test_fill.lua"   if file.exists(f) then dofile(f) end




--[[
x_dsleep=7   y_dsleep=30 dsleep()

i=1
jobtimer1=tmr.create()
tmr.alarm(jobtimer1, 1*1000,  tmr.ALARM_AUTO, function()
    print(i)   i=i+1
    if wifi.sta.getip() ~= nil then
        tmr.stop(jobtimer1)
        tmr.stop(ztmr_SLEEP)
        x_dsleep=300   y_dsleep=30 dsleep()
        print("c'est connecté...")
    end
end)
]]

