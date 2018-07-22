--Affiche l'adresse IP
--zf20180712.1110

tmr.alarm(0, 1000, tmr.ALARM_AUTO , function()
   if wifi.sta.getip() == nil then
      print("Connecting to AP...")
   else
      print("Connected! IP: ",wifi.sta.getip())
      tmr.stop(0)
   end
end)
