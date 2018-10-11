-- Scripts à charger au moment du boot afin de pouvoir travailler avec le robot à distance
print("\n start_boot.lua zf180907.1440 \n")

dofile("wifi_cli_conf.lua")
dofile("wifi_cli_start.lua")
dofile("web_led_onoff.lua")

