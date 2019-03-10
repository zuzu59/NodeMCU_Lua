-- Script pour chercher les prévision du jour de la pluie pour une ville
-- sur https://www.prevision-meteo.ch/services/json/lausanne

print("\n a_meteo1.lua zf190310.1946 \n")


function zget_json_key()
--    print("zget_json_key entrée...",zjson_stat)
    if zjson_header==1 then
        p1=string.find(zjson, [["hourly_data":{]])
        if p1~=nil then
--            print("trouvé le header: ",p1)
            zjson=string.sub(zjson,p1)
--            print(string.sub(zjson,1,100))
--            print("go go go...")
            zjson_header=2
        end
    end
    if zjson_header==2 then
--        print("len1: "..string.len(zjson))
        zjson_key='"'..zh..'H00":{'
--        print("zjson_key: ",zjson_key)
        p1=string.find(zjson, zjson_key)
--        print("p1: ",p1)
        if p1~=nil then
            zjson=string.sub(zjson,p1)
--            print("zjson: ",string.sub(zjson,1,100))
--            p1,p2=string.find(zjson, '"CONDITION_KEY":"')
            p1,p2=string.find(zjson, '"APCPsfc":')
--            print("p1: ",p1,"p2: ",p2)
            if p1~=nil then
--                p3=string.find(zjson, '","',p2)
                p3=string.find(zjson, ',',p2)
--                print("p3: ",p3)
                if p3~=nil then
                    zpluie=tonumber(string.sub(zjson,p2+1,p3-1))
                    print("heure: ",zjson_key,"zpluie: ",zpluie)
--                    print("len2: "..string.len(zjson))
                if zmeteo~="" then zmeteo=zmeteo.."," end
                zmeteo=zmeteo..zh..","..zpluie
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
--            print("ouille ouille ouille, pas trouvé...")
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
    -- site pour les données réelles
--    zport=80   zhost = "www.prevision-meteo.ch"   zurl = "/services/json/crissier"
    
    --site simulation pour les tests
    zport=80   zhost = "192.168.0.34"   zurl = "/json/meteo/meteo.lausanne.190302.1231.json"
    
    zhmin=0   zhmax=23   zh=zhmin   zmeteo=""
    zcmpt=1   zsum=0   zjson_header=1   zjson=""

    local s = net.createConnection()
    
    s:on("connection", function(sck, c)
--        print("on est connecté...")
        sck:send("GET "..zurl.." HTTP/1.1\r\nHost: "..zhost.."\r\nConnection: close\r\nAccept: */*\r\n\r\n")
    end)

    s:on("disconnection", function(a,b)
--        print("on est déconnecté...",a,b)
        print("la meteo est: "..zmeteo)
    end)
    
    s:on("reconnection", function(a,b)
        print("on est reconnecté...",a,b)
    end)
   
    s:on("receive", function(sck, c)
        zlen=string.len(c)   zsum=zsum+zlen
--        print("...zcmpt, zsum, zlen: ",zcmpt,zsum,zlen,string.sub(c,1,100))
--        print("len3: "..string.len(zjson))
--        print("zjson3: ",string.sub(zjson,1,100))
        zget_json(c)
        zcmpt=zcmpt+1
    end)
    
--    print("on se connecte...",node.heap())
    s:connect(zport, zhost)
end


--[[
f= "a_meteo1.lua"   if file.exists(f) then dofile(f) end   zget_meteo()

-- On affiche combien on a de RAM
print(node.heap())

-- On charge le module et regarde combien cela a pris de RAM
zh0=node.heap()   print("zh0: ",zh0)
f= "a_meteo1.lua"   if file.exists(f) then dofile(f) end
zh1=node.heap()   print("zh0-zh1: ",zh0-zh1)

-- On exécute le module
--zh0=node.heap()   print("zh0: ",zh0)
zget_meteo()

-- On regarde combien cela a pris de RAM pour exécuter le module
zh1=node.heap()   print("zh0-zh1: ",zh0-zh1)

-- On libère le module et on regarde combien on a libéré de RAM
--zh0=node.heap()   print("zh0: ",zh0)
zget_meteo=nil
zget_json_key=nil
zget_json=nil
zh1=node.heap()   print("zh0-zh1: ",zh0-zh1)

zport=nil   zhost=nill   zurl=nil
zhmin=nil   zhmax=nil   zh=nil
zcmpt=nil   zsum=nil   zjson_header=nil   zjson=nil   zlen=nil
zh1=node.heap()   print("zh0-zh1: ",zh0-zh1)

-- On affiche combien on a de RAM
print(node.heap())

]]
