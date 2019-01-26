-- petit script de serveur WEB Wifi

print("\n web_srv.lua   zf181018.1610   \n")

--dofile("web_get.lua")
--dofile("web_html.lua")

srv = net.createServer(net.TCP)
srv:listen(80, function(conn)
  conn:on("receive", function(client, request)
     _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP")

    print("\n\nweb_srv debug")
    print("request: \n---\n"..request.."---")
    print("method: ",method)
    print("path: ",path)
    print("vars: ",vars)

    if not string.find(request, "/favicon.ico") then
        print("coucou")
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
        file_html=string.gsub(path, "/", "")
        print("file_html: ",file_html)
        
        conn:send("<h1> ESP8266<BR>Server is working!</h1>\n\n")
        
    end
  end)
  conn:on("sent", function(c) c:close() end)
end)

 