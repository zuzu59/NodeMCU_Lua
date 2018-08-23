-- mini bootstrap pour le OLED NodeMCU mini D1
print("\ninit_oled_minid1.lua   zf20180724.2251   \n")

tmr.alarm(0, 10000, tmr.ALARM_SINGLE, function()
dofile("oled_first_minid1.lua")
dofile("web_oled_minid1.lua")
dofile("telnet_srv.lua")
dofile("wifi_ap_start.lua")
end)
