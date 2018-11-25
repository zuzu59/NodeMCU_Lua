
-- set AP mode
wifi.setmode(wifi.SOFTAP)
wifi.ap.config({ ssid = "webleds", pwd = "12345678" })
print("Started AP mode")

-- get and display our IP addr.
tmr.alarm(0, 1000, 1, function()
   if wifi.ap.getip() == nil then
      print("Getting AP info...")
   else
      print('IP: ', wifi.ap.getip())
      tmr.stop(0)
   end
end)

print()

