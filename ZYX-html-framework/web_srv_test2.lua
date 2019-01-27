-- petit script de serveur WEB pour tester les fuite mémoire

print("\n web_srv_test2.lua   zf190126.2335   \n")

function receiver(sck, data)
    print(data)
    sck:close()
end

function zclose(sck, data)
    print(data)
    sck:close()
end

sv = net.createServer()
sv:listen(80, function(conn)

  conn:on("receive", function(client, request)
    print(request)
--    client:close()
    conn:send("<h1> ESP8266<BR>Server is working!</h1>"..tmr.now().."\n\n")
--    conn:on("sent", function(c) c:close() end)
    conn:on("sent", zclose)
end)
    conn:on("sent", nil)


--  conn:on("sent", function(c) c:close() end)
end)

 
