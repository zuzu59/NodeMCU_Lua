--Petit serveur WEB pour allumer/éteindre une LED en mode client WIFI
print("\nweb_oled_minid1.lua   zf20180724.2230\n")

--[[
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
]]


srv = net.createServer(net.TCP)

srv:listen(80, function(conn)
  conn:on("receive", function(client, request)
    local buf = ""
    local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP")
    if (method == nil) then
     _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP")
    end
    local _GET = {}
    print("\nNouvelle entrée !")
    if (vars ~= nil) then
      print("Input: "..vars)
      for k, v in string.gmatch(vars, "(%w+)=([%w+-@%%]+)&*") do 
        _GET[k] = v
        print(k..": "..v)
      end
    end

    buf = buf .. "<!DOCTYPE html><html><body><h1>web_oled</h1></br><form name=\"hform\">"

        if  _GET.hinput=="Valider" then  
            disp_text=string.gsub(unescape(_GET.htext),"+"," ")
            print(disp_text)
            disp_page()
        end
   
    buf = buf .. "<textarea name=\"htext\">1'545W</textarea> </br> <input name=\"hinput\" type=\"submit\"></input></form></body></html>"
    client:send(buf)
  end)
  conn:on("sent", function(c) c:close() end)
end)


--source: https://github.com/diegonehab/luasocket/blob/master/src/url.lua
function unescape(s)
    return (string.gsub(s, "%%(%x%x)", function(hex)
        return string.char(tonumber(hex, 16))
    end))
end

--[[
--t1="hello+zuzu+%26+une+belle+%E9cole"
t1="hello+zuzu+%26+une+belle+%E9cole%5Cnun+b%E2teau"

print(string.char(tostring(tonumber("3F", 16))))
print(string.char(63))
print(unescape("%26"))
t3=string.gsub(unescape(t1),"+"," ")
print(t3)
t2="école\ntoto"
print(t2)

]]

--print( string.gsub("hello+zuzu+%26+une+belle+%E9cole%5Cun+b%E2teau","+"," ")

--[[ source OLED: 
https://www.google.ch/search?q=nodemcu+lua+oled+display&source=lnms&tbm=isch&sa=X&ved=0ahUKEwjG8ba8ra3cAhVDCpoKHedlDS4Q_AUICigB&biw=1536&bih=828
https://www.hackster.io/kayakpete/esp8266-oled-display-52ae50
http://blog.rl.cx/2017/01/08/bien-d%C3%A9buter-avec-nodemcu/
https://github.com/FredThx/nodemcu_iot/blob/master/i2c_display.lua
https://www.instructables.com/id/NODEMCU-LUA-ESP8266-With-I2C-LCD-128-X-64-OLED-Dis/
]]
