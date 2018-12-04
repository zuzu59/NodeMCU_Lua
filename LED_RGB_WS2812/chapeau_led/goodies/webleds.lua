-- initially based on https://github.com/nodemcu/nodemcu-firmware/blob/master/lua_examples/webap_toggle_pin.lua

-- start wifi client or AP mode
--dofile('wificlient.lua')
dofile('wifiap.lua')

-- LED init (strip with 72 leds)
print("Initializing LED strip...")
ws2812.init()
strip_buffer = ws2812.newBuffer(6, 3)
ws2812_effects.init(strip_buffer)
-- initially all leds off
ws2812_effects.set_speed(200)
ws2812_effects.set_brightness(0)
ws2812_effects.set_color(0,0,0)
ws2812_effects.start()
print("done.")
print()

-- helper functions
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
    if (method == nil) then
      _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP")
    end
    local _GET = {}
    if (vars ~= nil) then
      for k, v in string.gmatch(vars, "(%w+)=([a-z0-9_]+)&*") do
        _GET[k] = v
      end
    end
    if (_GET.set == "effect") then
      print("setting effect", _GET.effect)
      ws2812_effects.set_mode(_GET.effect)
      ws2812_effects.set_speed(200)
      ws2812_effects.set_brightness(50)
      ws2812_effects.start()
    end
    if (_GET.set == "color") then
      print("setting color (RGB)", _GET.r, _GET.g, _GET.b)
      ws2812_effects.set_color(_GET.g, _GET.r, _GET.b) -- obviously our strip is GRB and not RGB
    end
    send_file(client, 'index.html')
  end)
  conn:on("sent", function(c) c:close() end)
end)

