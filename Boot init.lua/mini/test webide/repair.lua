-- Scripts de seconde chance pour réparer une boucle dans le restart

print("\n repair.lua zf181120.1012 \n")

--if file.exists("wifi_ap_start.lua") then dofile("wifi_ap_start.lua") end
if file.exists("wifi_ap_stop.lua") then dofile("wifi_ap_stop.lua") end
if file.exists("wifi_cli_conf.lua") then dofile("wifi_cli_conf.lua") end
if file.exists("wifi_cli_start.lua") then dofile("wifi_cli_start.lua") end
if file.exists("ide.lua") then dofile("ide.lua") end
if file.exists("telnet_srv.lua") then dofile("telnet_srv.lua") end

jobtimer1=tmr.create()
tmr.alarm(jobtimer1, 5*1000,  tmr.ALARM_AUTO, function()
--    print("repair...")
end)
