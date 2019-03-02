-- Juste un tests pour voir si on arrive juste à afficher en live un JSON
-- pour aller chercher les prévision de la pluie pour une ville sur Internet
-- Permet de ne prendre que ce qui est nécéssaire dans un grand flux JSON
-- affiche de https://www.prevision-meteo.ch/services/json/lausanne
-- les conditions pour toutes les heures la journée
-- Source: https://github.com/nodemcu/nodemcu-firmware/blob/master/lua_examples/sjson-streaming.lua

print("\n a_meteo2-tests.lua zf190302.1934 \n")

local s = tls.createConnection()
s:on("connection", function(sck, c)
--  sck:send("GET /repos/nodemcu/nodemcu-firmware/git/trees/master HTTP/1.0\r\nUser-agent: nodemcu/0.1\r\nHost: api.github.com\r\nConnection: close\r\nAccept: application/json\r\n\r\n")
--  sck:send("GET /services/json/lausanne HTTP/1.0\r\nHost: www.prevision-meteo.ch\r\n\r\n")
  sck:send("GET /services/json/Lausanne HTTP/1.0\r\nHost: www.prevision-meteo.ch\r\n\r\n")
end)

-- The receive callback is somewhat gnarly as it has to deal with find the end of the header
-- and having the newline sequence split across packets
s:on("receive", function(sck, c)
    print(c)
end)

local function getresult()
  print(node.heap())
end

s:on("disconnection", getresult)
s:on("reconnection", getresult)

-- Make it all happen!
--s:connect(443, "api.github.com")
s:connect(443, "www.prevision-meteo.ch")

