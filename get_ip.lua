-- get_ip.lua
-- branche le wifi et affiche l'adresse IP
-- zf180719.1039

wifi.sta.connect()

tmr.alarm(0, 1000, tmr.ALARM_AUTO , function()
   if wifi.sta.getip() == nil then
      print("Connecting to AP...")
   else
      print("Connected! IP: ",wifi.sta.getip())
      tmr.stop(0)
   end
end)
