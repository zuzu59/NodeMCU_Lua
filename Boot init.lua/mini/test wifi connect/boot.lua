-- Scripts à charger après le boot pour démarrer son appli

print("\n boot.lua zf181119.2351 \n")

f= "wifi_ap_stop.lua"   if file.exists(f) then dofile(f) end
--f= "wifi_cli_conf.lua"   if file.exists(f) then dofile(f) end
f= "wifi_cli_start.lua"   if file.exists(f) then dofile(f) end
f= "dsleep.lua"   if file.exists(f) then dofile(f) end

x_dsleep=7   y_dsleep=5 dsleep()

jobtimer1=tmr.create()
tmr.alarm(jobtimer1, 1*1000,  tmr.ALARM_AUTO, function()
    print("coucou...")
    if wifi.sta.getip() ~= nil then
        tmr.stop(jobtimer1)
        tmr.stop(ztmr_SLEEP)
        x_dsleep=12   y_dsleep=5 dsleep()
        print("c'est connecté...")
    end
end)
