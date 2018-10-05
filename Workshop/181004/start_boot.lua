-- Scripts à charger au moment du boot afin de pouvoir travailler avec le robot à distance
print("\n start_boot.lua zf180907.1440 \n")

dofile("disp_oled.lua")
oled_line1="RESET"
oled_line2=""
oled_line3=""
oled_line4=""
oled_line5=""
disp_oled()

oled_line1="Waiting..."
oled_line2=""
oled_line3=""
oled_line4=""
oled_line5=""
disp_oled()

--dofile("wifi_cnf_start.lua")
dofile("wifi_ap_stop.lua")
dofile("wifi_cli_start.lua")
dofile("web_srv.lua")
dofile("telnet_srv.lua")

zpeed=50
turn_on = 700
zauto=false
dofile("motor.lua")
