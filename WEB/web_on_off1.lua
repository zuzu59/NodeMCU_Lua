--Petit serveur WEB pour allumer/éteindre une LED en mode client WIFI
print("\nDémarrage hv&zf20180718.1041\n")

--wifi.sta.disconnect()
--wifi.setmode(wifi.STATION)
--print("set mode=STATION (mode="..wifi.getmode()..")")
--wifi.sta.config{ssid="Hugo", pwd="tototutu"}

wifi.sta.connect()
tmr.alarm(0, 1000, tmr.ALARM_AUTO , function()
   if wifi.sta.getip() == nil then
      print("Connecting to AP...")
   else
      print("Connected! IP: ",wifi.sta.getip())
      tmr.stop(0)
   end
end)

zLED=0

gpio.mode(zLED, gpio.OUTPUT)
gpio.write(zLED, gpio.HIGH)
srv = net.createServer(net.TCP)
srv:listen(80, function(conn)
  conn:on("receive", function(client, request)
    local buf = ""
    local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP")
    if (method == nil) then
      _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP")
    end
    local _GET = {}
    if (vars ~= nil) then
      for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
        _GET[k] = v
      end
    end
    buf = buf .. "<!DOCTYPE html><html><body><h1>Hello, this is NodeMCU.</h1>Turn PIN : </br></br>"
    local _on, _off = "", ""
    if (_GET.pin == "ON") then
      _on = " selected=true"
      gpio.write(zLED, gpio.LOW)
    elseif (_GET.pin == "OFF") then
      _off = " selected=\"true\""
      gpio.write(zLED, gpio.HIGH)
    end
     buf = buf .. "<a href=\"?pin=ON\"><button>ON</button></a> <a href=\"?pin=OFF\"><button>OFF</button></a>"
    client:send(buf)
  end)
  conn:on("sent", function(c) c:close() end)
end)

