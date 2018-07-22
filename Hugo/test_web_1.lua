--Connexion en mode client WIFI
--hv20180711.1501

print("Démarrage")
wifi.sta.disconnect()
wifi.setmode(wifi.STATION)
print("set mode=STATION (mode="..wifi.getmode()..")")
wifi.sta.config{ssid="Hugo", pwd="tototutu"}
 
tmr.alarm(0, 1000, tmr.ALARM_AUTO , function()
   if wifi.sta.getip() == nil then
      print("Connecting to AP...")
   else
      print("Connected! IP: ",wifi.sta.getip())
      tmr.stop(0)
   end
end)







