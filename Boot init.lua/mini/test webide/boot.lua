-- Scripts à charger après le boot pour démarrer son appli

print("\n boot.lua zf181119.1518 \n")

--if file.exists("wifi_ap_stop.lua") then dofile("wifi_ap_stop.lua") end
--if file.exists("dsleep.lua") then dofile("dsleep.lua") end
--if file.exists("wifi_cli_start.lua") then dofile("wifi_cli_start.lua") end
if file.exists("repair.lua") then dofile("repair.lua") end

jobtimer1=tmr.create()
--tmr.alarm(jobtimer1, 1*1000,  tmr.ALARM_AUTO, function()
--    print("coucou...")
--end)
