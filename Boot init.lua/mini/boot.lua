-- Scripts à charger après le boot pour démarrer son appli

print("\n boot.lua zf181118.2329 \n")

if file.exists("wifi_ap_stop.lua") then dofile("wifi_ap_stop.lua") end
if file.exists("dsleep.lua") then dofile("dsleep.lua") end

jobtimer1=tmr.create()
tmr.alarm(jobtimer1, 1*1000,  tmr.ALARM_AUTO, function()
    print("coucou...")
end)
