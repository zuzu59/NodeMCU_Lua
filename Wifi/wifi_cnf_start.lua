-- Petit script pour démarrer le mode configuration WIFI du NodeMCU
print("\wifi_cnf_start.lua   zf180822.1540   \n")

print("\nwifi config http://192.168.4.1\n")
dofile("wifi_get_ip.lua")
enduser_setup.start()

