-- super mini bootstrap 
print("\n init_minizf1.lua   zf181024.1922   \n")

tmr.alarm(0, 7000, tmr.ALARM_SINGLE, function()

dofile("disp_oled.lua")
oled_line1="RESET"
oled_line2=""
oled_line3=""
oled_line4=""
oled_line5=""
disp_oled()

--dofile("wifi_ap_start.lua")
--dofile("telnet_srv.lua")
dofile("start_demo.lua")
--dofile("ir_send.lua")

end)
