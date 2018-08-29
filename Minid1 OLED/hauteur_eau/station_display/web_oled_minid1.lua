--Petit serveur WEB pour afficher des choses sur un mini display OLED minid1
print("\n web_oled_minid1.lua   zf180828.1812 \n")

--source: https://github.com/diegonehab/luasocket/blob/master/src/url.lua
function unescape(s)
    return (string.gsub(s, "%%(%x%x)", function(hex)
        return string.char(tonumber(hex, 16))
    end))
end

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

    f1=false
    if _GET.line1 then oled_line1=_GET.line1 f1=true else oled_line1="" end
    if _GET.line2 then oled_line2=_GET.line2 f1=true else oled_line2="" end
    if _GET.line3 then oled_line3=_GET.line3 f1=true else oled_line3="" end
    if _GET.line4 then oled_line4=_GET.line4 f1=true else oled_line4="" end
    if _GET.line5 then oled_line5=_GET.line5 f1=true else oled_line5="" end
    if f1 then disp_oled() end
       
    buf = "<!DOCTYPE html><html><body><h1>web_oled</h1>".."\n"
    buf = buf.."<form action='/' method='get' id='hform'>"
    buf = buf.."line1: <input type='text' name='line1' value='"..oled_line1.."'><br>".."\n"
    buf = buf.."line2: <input type='text' name='line2' value='"..oled_line2.."'><br>".."\n"
    buf = buf.."line3: <input type='text' name='line3' value='"..oled_line3.."'><br>".."\n"
    buf = buf.."line4: <input type='text' name='line4' value='"..oled_line4.."'><br>".."\n"
    buf = buf.."line5: <input type='text' name='line5' value='"..oled_line5.."'><br>".."\n"
    buf = buf.."</form><br>".."\n"
    buf = buf.."<button type='submit' form='hform' value='Submit'>ok</button>".."\n"
    buf = buf.."</body></html>".."\n"
    client:send(buf)
  end)
  conn:on("sent", function(c) c:close() end)
end)

