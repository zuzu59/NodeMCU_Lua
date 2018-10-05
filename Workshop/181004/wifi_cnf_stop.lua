-- Petit script pour arrêter le mode configuration WIFI du NodeMCU
print("\n wifi_cnf_stop.lua   zf180824.2000   \n")

enduser_setup.stop()
wifi.sta.autoconnect(1)
wifi.sta.connect()-- Petit script pour arrêter le mode configuration WIFI du NodeMCU
