-- Scripts à charger au moment du boot afin de pouvoir travailler avec le robot à distance
print("\n start_boot.lua zf181015.1643 \n")

dofile("wifi_cli_stop.lua")
dofile("wifi_ap_start.lua")
dofile("web_led_onoff.lua")
dofile("flash_led_xfois.lua")


