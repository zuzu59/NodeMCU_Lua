-- petit script de serveur WEB pour tester les fuite mémoire

print("\n web_srv_test.lua   zf190126.2014   \n")

sv = net.createServer()

function receiver(sck, data)
  print(data)
  sck:close()
end

sv:listen(80, function(conn)
    conn:on("receive", receiver)
    conn:send("<h1> ESP8266<BR>Server is working!</h1>"..tmr.now().."\n\n")
end)


