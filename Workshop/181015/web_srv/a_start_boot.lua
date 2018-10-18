-- Scripts à charger au moment du boot

print("\n a_start_boot.lua zf181018.1624 \n")

--dofile("wifi_ap_stop.lua")
--dofile("wifi_cli_conf.lua")
dofile("wifi_cli_start.lua")

dofile("led_job.lua")
dofile("web_srv.lua")

dofile("flash_led_xfois.lua")




