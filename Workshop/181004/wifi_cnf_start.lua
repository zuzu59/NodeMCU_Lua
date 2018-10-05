-- Petit script pour démarrer le mode configuration WIFI du NodeMCU
print("\n wifi_cnf_start.lua   zf180906.1610   \n")

print("\nwifi config http://192.168.4.1\n")
--dofile("wifi_ap_stop.lua")
--dofile("wifi_cli_stop.lua")

srv:close()
telnet_srv:close()

--wificnftimer1=tmr.create()
--tmr.alarm(wificnftimer1, 3000, tmr.ALARM_SINGLE, function()
print("coucou")
    enduser_setup.start()
--end)
