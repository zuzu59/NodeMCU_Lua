-- Juste pour tester la connection avec un socket

print("\n a_test1_connect.lua zf190310.1607 \n")

function zgetstream()
    zgetstream_tmr=tmr.create()
    tmr.alarm(zgetstream_tmr, 1000, tmr.ALARM_AUTO , function()
        if wifi.sta.getip() == nil then
            print("Connecting to AP...")
        else
            tmr.unregister(zgetstream_tmr)
            zgetstream_tmr = nil

            zcount = 0   zsum = 0
            zhost = "192.168.0.34"   zurl = "/json/meteo/meteo.lausanne.190302.1231.json"
            
            srv = net.createConnection(net.TCP, 0)
            
            srv:on("connection", function(sck, c)
                print("on est connecté...")
                sck:send("GET "..zurl.." HTTP/1.1\r\nHost: "..zhost.."\r\nConnection: close\r\nAccept: */*\r\n\r\n")
            end)
            
            srv:on("disconnection", function(a,b)
                print("a: ",a,"b: ",b)
                print("on est déconnecté...",node.heap())
            end)
            
            srv:on("reconnection", function(a,b)
                print("a: ",a,"b: ",b)
                print("on est reconnecté...",node.heap())
            end)
            
            srv:on("receive", function(sck, payload)
                zcount = zcount + 1   zlen = string.len(payload)   zsum = zsum + zlen
                print("counter: ",zcount,"payload len: ",zlen,"sum: ",zsum)
            --        print(payload)
            end)
            
            print("on connecte...",node.heap())
            srv:connect(80, zhost)
        end
    end)
end


--[[
-- On affiche combien on a de RAM
print(node.heap())

-- On charge le module et regarde combien cela a pris de RAM
zh0=node.heap()   print("zh0: ",zh0)
f= "a_test1_connect.lua"   if file.exists(f) then dofile(f) end
zh1=node.heap()   print("zh0-zh1: ",zh0-zh1)

-- On exécute le module
zh0=node.heap()   print("zh0: ",zh0)
zgetstream()

-- On regarde combien cela a pris de RAM pour exécuter le module
zh1=node.heap()   print("zh0-zh1: ",zh0-zh1)

-- On libère le module et on regarde combien on a libéré de RAM
zh0=node.heap()   print("zh0: ",zh0)
srv = nil
zgetstream = nil
zh1=node.heap()   print("zh0-zh1: ",zh0-zh1)

-- On affiche combien on a de RAM
print(node.heap())

]]
