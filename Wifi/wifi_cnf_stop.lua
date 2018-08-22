-- Petit script pour arrêter le mode configuration WIFI du NodeMCU
print("\wifi_cnf_stop.lua   zf180822.1538   \n")

enduser_setup.stop()
wifi.sta.autoconnect(1)
wifi.sta.connect()
