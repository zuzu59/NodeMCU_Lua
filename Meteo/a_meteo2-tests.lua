-- Juste un tests pour voir si on arrive juste à afficher en live un JSON
-- pour aller chercher les prévision de la pluie pour une ville sur Internet
-- Permet de ne prendre que ce qui est nécéssaire dans un grand flux JSON
-- affiche de https://www.prevision-meteo.ch/services/json/lausanne
-- les conditions pour toutes les heures la journée
-- Source: https://github.com/nodemcu/nodemcu-firmware/blob/master/lua_examples/sjson-streaming.lua

print("\n a_meteo2-tests.lua zf190306.1505 \n")

dofile("a_meteo3-tests.lua")

--zhost="www.prevision-meteo.ch"
--zport=80
--zpath="/services/json/lausanne"

zhost="192.168.0.153"
zport=8080
zpath="/meteo.lausanne.190302.1231.json"

--local s = tls.createConnection()
local s = net.createConnection()

s:on("connection", function(sck, c)
--  sck:send("GET /repos/nodemcu/nodemcu-firmware/git/trees/master HTTP/1.0\r\nUser-agent: nodemcu/0.1\r\nHost: api.github.com\r\nConnection: close\r\nAccept: application/json\r\n\r\n")
--  sck:send("GET /services/json/lausanne HTTP/1.0\r\nHost: www.prevision-meteo.ch\r\n\r\n")
    sck:send("GET "..zpath.." HTTP/1.0\r\nHost: "..zhost.."\r\n\r\n")
end)

zcmpt=1
zsum=0
s:on("receive", function(sck, c)
    zlen=string.len(c)
    zsum=zsum+zlen
    print("...zcmpt, zsum, zlen: ",zcmpt,zsum,zlen,string.sub(c,1,100))
--    print(node.heap())
--    print("len3: "..string.len(zjson))
--    print("zjson3: ",string.sub(zjson,1,100))
    ztoto(c)
    zcmpt=zcmpt+1
end)

local function zdisconnection()
    print("disconnect",node.heap())
end

local function zreconnection()
    print("reconnect",node.heap())
end

s:on("disconnection", zdisconnection)
s:on("reconnection", zreconnection)
s:connect(zport, zhost)

