-- petit script de serveur WEB Wifi

print("\n web_srv.lua   zf200302.2323   \n")

dofile("web_get.lua")
dofile("web_html.lua")

srv = net.createServer(net.TCP)
srv:listen(80, function(conn)
  conn:on("receive", function(client, request)
     _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP")

    --print("\n\nweb_srv")
    --print("method: ",method)
    --print("path: ",path)
    --print("request: ",request)
    --print("vars: ",vars)

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
        web_get()
--        html_home()
        --print("send html...")
        client:send(buf)
        buf=nil
    end
  end)
  conn:on("sent", function(c) c:close() end)
end)
