--Petit serveur WEB pour allumer/éteindre une LED en mode client WIFI
print("\nDémarrage hv20180711.1606\n")

hvtime=tmr.create()
wifi.sta.connect()
tmr.alarm(hvtime, 1000, tmr.ALARM_AUTO , function()
   if wifi.sta.getip() == nil then
      print("Connecting to AP...")
   else
      print("Connected! IP: ",wifi.sta.getip())
      tmr.stop(hvtime)
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
    buf = buf .. "<!DOCTYPE html><html><body><h1>Faire avancer ou arreter le robot</h1></br></br>"
    local _on, _off = "", ""
    if (_GET.pin == "Forward") then
        _on = " selected=true"
        avance_robot()
        gpio.write(zLED, gpio.LOW)
    elseif (_GET.pin == "Backward") then
        _off = " selected=\"true\""
        stop_robot()
        gpio.write(zLED, gpio.HIGH)
    end
     buf = buf .. "<a href=\"?pin=Forward\"><button>Forward</button></a> <a href=\"?pin=Backward\"><button>Backward</button></a>"
    client:send(buf)
  end)
  conn:on("sent", function(c) c:close() end)
end)

