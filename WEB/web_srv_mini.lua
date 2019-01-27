-- petit script de serveur WEB minimaliste

print("\n web_srv_mini.lua   zf190127.1017   \n")

srv = net.createServer(net.TCP)

srv:listen(80, function(conn)
    conn:on("receive", function(client, request)
        print(request)
        client:send("<h1> ESP8266<br>Server is working!</h1>"..tmr.now())
    end)
    conn:on("sent", function(c) c:close() end)
end)
