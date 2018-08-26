-- super mini bootstrap 
print("\n init_minizf1.lua   zf180824.2019   \n")

tmr.alarm(0, 5000, tmr.ALARM_SINGLE, function()
dofile("wifi_ap_start.lua")
dofile("telnet_srv.lua")
end)
