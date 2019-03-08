-- Juste pour tester la connection avec un socket

print("\n a_test1_connect.lua zf190308.1733 \n")

function zgetstats()
    counter = 0

    local srv = net.createConnection(net.TCP, 0)

    srv:on("receive", function(sck, payload)
        print("[stats] received data, " .. string.len(payload))
        counter = counter + 1
    end)

    srv:on("connection", function(sck, c)
        print("on est connecté...")
        sck:send("GET /meteo.lausanne.190302.1231.json HTTP/1.1\r\nHost: 192.168.0.153\r\nConnection: close\r\nAccept: */*\r\n\r\n")
    end)



    local function zdisconnection(a,b)
        print("a: ",a,"b: ",b)
        print("disconnect",node.heap())
        print("pluie_am: ",zpluie_am,"pluie_pm: ",zpluie_pm)
    end
    
    local function zreconnection(a,b)
        print("a: ",a,"b: ",b)
        print("reconnect",node.heap())
    end
    
    srv:on("disconnection", zdisconnection)
    srv:on("reconnection", zreconnection)


    print("on connecte...")
--    srv:connect(8080, "192.168.0.153")
    srv:connect(80, "z.zufferey.com")
end


--[[
zgetstats()
]]
