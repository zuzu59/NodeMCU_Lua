-- Script pour chercher les prévision de la pluie pour une ville de 7h à 19h
-- sur https://www.prevision-meteo.ch/services/json/lausanne

print("\n a_meteo1.lua zf190308.1703 \n")

-- site pour les données réelles
--zhost="www.prevision-meteo.ch"
--zport=80
--zpath="/services/json/lausanne"

--site simulation pour les tests (petit webserver sur mon MAC)
zhost="192.168.0.153"
zport=8080
zpath="/meteo.lausanne.190302.1231.json"
--zpath="/meteo.lausanne.190304.0930.json"
--zpath="/meteo.st-luc.190304.0930.json"

zhmin=7
zhmax=19

function zget_json_key()
--    print("zget_json_key entrée...",zjson_stat)
    if zjson_header==1 then
        p1=string.find(zjson, [["hourly_data":{]])
        if p1~=nil then
            print("trouvé le header: ",p1)
            zjson=string.sub(zjson,p1)
            print(string.sub(zjson,1,100))
            print("go go go...")
            zjson_header=2
        end
    end
    if zjson_header==2 then
--        print("len1: "..string.len(zjson))
        zjson_key='"'..zh..'H00":{'
        print("zjson_key: "..zjson_key)
        p1=string.find(zjson, zjson_key)
        print("p1: ",p1)
        if p1~=nil then
            zjson=string.sub(zjson,p1)
            print("zjson: ",string.sub(zjson,1,100))
--            p1,p2=string.find(zjson, '"CONDITION_KEY":"')
            p1,p2=string.find(zjson, '"APCPsfc":')

            
            print(p1,p2)
            if p1~=nil then
--                p3=string.find(zjson, '","',p2)
                p3=string.find(zjson, ',',p2)
                print(p3)
                if p3~=nil then
                    zpluie=tonumber(string.sub(zjson,p2+1,p3-1))
                    print("zpluie: ",zpluie)
--                    print("len2: "..string.len(zjson))
                if zh >=7 and zh<=13 then
                    zpluie_am=zpluie_am+zpluie
                end
                if zh >=13 and zh<=19 then
                    zpluie_pm=zpluie_pm+zpluie
                end
                
                end
            end
        end
    end
--    print("zget_json_key sortie...",zjson_stat)
end



function zget_json(c1)
--    print("zget_json entrée...")
    if zjson=="" then
        zjson=c1
    else
        zjson=zjson..c1
    end
--    print("zh: ",zh,"len(zjson): ",string.len(zjson))
    while zh<=zhmax do
        zget_json_key()
        if p1~=nil then
            zh=zh+1            
        else
            print("ouille ouille ouille, pas trouvé...")
            if string.len(zjson)>510 then
                zjson=string.sub(zjson,string.len(zjson)-500)
            end
            break
        end
    end
    if zh>zhmax then
        zjson=""
    end
--    print("zget_json sortie...")
end


function zget_meteo()
    zh=zhmin
    zpluie_am=0
    zpluie_pm=0
    zjson_header=1
    zjson=""

    local s = net.createConnection()
    
    s:on("connection", function(sck, c)
        print("connected...")
    --  sck:send("GET /services/json/lausanne HTTP/1.0\r\nHost: www.prevision-meteo.ch\r\n\r\n")
        zstring="GET "..zpath.." HTTP/1.0\r\nHost: "..zhost.."\r\n\r\n"
        print("ztring: ",zstring)
        sck:send(zstring)
    end)
    
    zcmpt=1
    zsum=0
    s:on("receive", function(sck, c)
        zlen=string.len(c)
        zsum=zsum+zlen
--        print("...zcmpt, zsum, zlen: ",zcmpt,zsum,zlen,string.sub(c,1,100))
        print(node.heap())
    --    print("len3: "..string.len(zjson))
    --    print("zjson3: ",string.sub(zjson,1,100))
--        zget_json(c)
        zcmpt=zcmpt+1
    end)
    
    local function zdisconnection()
        print("disconnect",node.heap())
        print("pluie_am: ",zpluie_am,"pluie_pm: ",zpluie_pm)
    end
    
    local function zreconnection()
        print("reconnect",node.heap())
    end
    
    s:on("disconnection", zdisconnection)
    s:on("reconnection", zreconnection)
    print("zport: ",zport,"zhost: ",zhost)
    s:connect(zport, zhost)

end


function getstats()
  buffer = nil
  counter = 0
  local srv = tls.createConnection()
  srv:on("receive", function(sck, payload)
    print("[stats] received data, " .. string.len(payload))
--[[    if buffer == nil then
      buffer = payload
    else
      buffer = buffer .. payload
    end
]]
    counter = counter + 1

    -- not getting HTTP content-length header back -> poor man's checking for complete response
--[[
if counter == 2 then
      print("[stats] done, processing payload")
      local beginJsonString = buffer:find("{")
      local jsonString = buffer:sub(beginJsonString)
      local hashrate = sjson.decode(jsonString)["stats"]["hashrate"]
      print("[stats] hashrate from aeon-pool.com: " .. hashrate)
    end
]]
    end)
  srv:on("connection", function(sck, c)
    print("on est connecté...")
    sck:send("GET /meteo.lausanne.190302.1231.json HTTP/1.1\r\nHost: 192.168.0.153\r\nConnection: close\r\nAccept: */*\r\n\r\n")
  end)

  print("on connecte...")
  srv:connect(8080, "192.168.0.153")
end


--[[
getstats()
zget_meteo()
]]