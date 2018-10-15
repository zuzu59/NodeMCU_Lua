-- Scripts à charger au moment du boot afin de pouvoir travailler avec le robot à distance
print("\n start_boot.lua zf181015.1642 \n")

dofile("wifi_ap_stop.lua")
dofile("wifi_cli_conf.lua")
dofile("wifi_cli_start.lua")
dofile("web_cli.lua")
dofile("btn_led.lua")
dofile("flash_led_xfois.lua")

