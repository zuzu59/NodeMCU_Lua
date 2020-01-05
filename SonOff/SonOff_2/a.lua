print("a start... zf190105.2344")


srv:close()
srv=nil

wifi.setmode(wifi.NULLMODE,true)

print("toto")
tmr.delay(1*1000*1000)
print("tutu")

wifi.setmode(wifi.STATIONAP,true)

wifi.sta.config{ssid="", pwd="", auto=true, save=true}
wifi.sta.autoconnect(1)   wifi.sta.connect()
wifi.ap.config({ ssid = "toto", auth=wifi.OPEN, save=true })

wifi.setmode(wifi.STATION,true)

--wifi.setmode(wifi.STATIONAP)
--wifi.ap.config({ssid="MyPersonalSSID", auth=wifi.OPEN})
--enduser_setup.manual(true)

--[[
srv:close()
srv=nil

wifi.setmode(wifi.NULLMODE,true)

print("toto")
a1=tmr.create()
a1:alarm(10*1000,  tmr.ALARM_SINGLE, function()
    enduser_setup.start(
      function()
        print("Connected to WiFi as:" .. wifi.sta.getip())
      end,
      function(err, str)
        print("enduser_setup: Err #" .. err .. ": " .. str)
      end,
      print -- Lua print function can serve as the debug callback
    )    
    print(node.heap())   collectgarbage()   print(node.heap())
    print("tutu")
end)

]]


