-- Scripts pour tester l'occupation méroire des différents modules
-- source: 

print("\n a_test_ram.lua zf190126.1845 \n")

test_ram_alarm1=tmr.create()
test_ram_alarm2=tmr.create()
zram0=node.heap()   zram1=node.heap()

tmr.alarm(test_ram_alarm1, 1*1000,  tmr.ALARM_AUTO, function()
    zram2=node.heap()   print(zram0, zram1, zram2, zram1-zram2, zram0-zram2)
end)

--[[
file.remove("telnet_srv2.lc")
file.remove("web_ide2.lc")
file.remove("web_srv.lc")
file.remove("set_time.lc")

node.compile("telnet_srv2.lua")
node.compile("web_ide2.lua")
node.compile("web_srv.lua")
node.compile("set_time.lua")

file.remove("telnet_srv2.lua")
file.remove("web_ide2.lua")
file.remove("web_srv.lua")
file.remove("set_time.lua")
]]

tmr.alarm(test_ram_alarm2, 5*1000,  tmr.ALARM_SINGLE, function()
    zram1=node.heap()
--    dofile("telnet_srv2.lua")
--    dofile("web_ide2.lua")
    dofile("web_srv_test2.lua")
--    dofile("set_time.lua")
--    dofile("web_html.lua")

    
--      dofile("telnet_srv2.lc")
--    dofile("web_ide2.lc")
--    dofile("web_srv.lc")
--    dofile("set_time.lc")

    zram2=node.heap()
end)

    f= "wifi_ap_start.lua"   if file.exists(f) then dofile(f) end
    f= "wifi_cli_conf.lua"   if file.exists(f) then dofile(f) end
    f= "wifi_cli_start.lua"   if file.exists(f) then dofile(f) end

--[[
tmr.stop(test_ram_alarm1)
package.loaded ["telnet_srv2.lua.lua"] = nil 
package.loaded ["wifi_ap_start.lua"] = nil 


]]


--[[
f= "wifi_ap_start.lua"   if file.exists(f) then dofile(f) end
f= "wifi_cli_conf.lua"   if file.exists(f) then dofile(f) end
f= "wifi_cli_start.lua"   if file.exists(f) then dofile(f) end
f= "telnet_srv2.lua"   if file.exists(f) then dofile(f) end
f= "web_ide2.lua"   if file.exists(f) then dofile(f) end
f= "web_srv.lua"   if file.exists(f) then dofile(f) end
f= "set_time.lua"   if file.exists(f) then dofile(f) end
]]
