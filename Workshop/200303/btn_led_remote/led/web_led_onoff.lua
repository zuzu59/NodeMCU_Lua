--Petit serveur WEB pour allumer/éteindre une LED en mode serveur WIFI

print("\n web_ledstate_onoff.lua   zf200717.1734   \n")

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
    buf = "<!DOCTYPE html><html><body><h1>Hello, this is NodeMCU.</h1>"
    buf = buf .. "<form src=\"/\">Turn PIN <select name=\"pin\" onchange=\"form.submit()\">"
    local state_on, state_off = "", ""
    if (_GET.pin == "ON") then
      state_on = " selected=\"true\""
      gpio.write(zLED, gpio.LOW)
    elseif (_GET.pin == "OFF") then
      state_off = " selected=\"true\""
      gpio.write(zLED, gpio.HIGH)
    elseif (_GET.pin == "zuzu") then
      print("hello zuzu")
    end
    buf = buf .. "<option" .. state_off .. ">OFF</option><option" .. state_on .. ">ON</option></select></form>"
    buf = buf .. "</body></html>"
    client:send("HTTP/1.1 200 OK\r\n\r\n")
    client:send(buf)
  end)
  conn:on("sent", function(c) c:close() end)
end)
