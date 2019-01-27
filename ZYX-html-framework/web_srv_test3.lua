-- petit script de serveur WEB pour tester les fuite mémoire

print("\n web_srv_test3.lua   zf190127.0141   \n")

sck_tmr1 = tmr.create()

srv = net.createServer(net.TCP)
srv:listen(80, function(conn)
  conn:on("receive", function(client, request)
    print(request)
    client:send("<h1> ESP8266<BR>Server is working!</h1>"..tmr.now().."\n\n")


  end)
  conn:on("sent", function(c) c:close() end)
end)
