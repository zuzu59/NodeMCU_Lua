-- Scripts à charger au moment du boot

print("\n a_start_boot.lua zf200302.2315 \n")

dofile("wifi_ap_stop.lua")
dofile("wifi_cli_conf.lua")
dofile("wifi_cli_start.lua")

dofile("led_job.lua")
dofile("web_srv.lua")

dofile("flash_led_xfois.lua")




