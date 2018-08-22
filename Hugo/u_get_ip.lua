-- get_ip.lua
-- affiche l'adresse IP
-- zf180718.1103

wifi.sta.connect()

tmr.alarm(0, 1000, tmr.ALARM_AUTO , function()
   if wifi.sta.getip() == nil then
      print("Connecting to AP...")
   else
      print("Connected! IP: ",wifi.sta.getip())
      tmr.stop(0)
   end
end)
