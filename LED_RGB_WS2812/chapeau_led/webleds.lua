-- Petit script de serveur WEB pour piloter les effets des LED RGB
-- source: https://github.com/nodemcu/nodemcu-firmware/blob/master/lua_examples/webap_toggle_pin.lua

print("\n webleds.lua   zf181205.2101   \n")


-- send a file from memory to the client; max. line length = 1024 bytes!
function send_file(client, filename)
  if file.open(filename, "r") then
    repeat
      local line=file.read('\n')
      if line then
        client:send(line)
      end
    until not line    
    file.close()
  end
end

-- web server
srv = net.createServer(net.TCP)
srv:listen(80, function(conn)
  conn:on("receive", function(client, request)
    local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP")
    if not string.find(request, "/favicon.ico") then
        --print("coucou")
        if (method == nil) then
         _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP")
        end
        _GET = {}
        if (vars ~= nil) then
          for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
            _GET[k] = v
            print(k..": "..v)
          end
        end

        if (_GET.fonction == "start") then
            train_start()
        end

        if (_GET.fonction == "stop") then
            train_stop()
        end

        if (_GET.set == "speed") then
            train_stop()
            if (_GET.speed == "inc") then
                train_speed=train_speed*0.8
            else
                train_speed=train_speed*1.2
            end
            train_start()
        end    
     
        if (_GET.set == "color") then
            print("setting color (RGB)", _GET.R1, _GET.G1, _GET.B1)
            train_stop()
            R1=_GET.R1   G1=_GET.G1   B1=_GET.B1
            R2=_GET.R2   G2=_GET.G2   B2=_GET.B2
            train1_fill()
            train2_fill()
            train_start()
        end    

        if (_GET.restart == "1") then
            restarttimer1=tmr.create()
            tmr.alarm(restarttimer1, 2*1000,  tmr.ALARM_SINGLE, function()
                node.restart()
            end)
        end

        
        print("send html...")
        send_file(client, 'index.html')
    end  
  end)
  conn:on("sent", function(c) c:close() end)
end)

