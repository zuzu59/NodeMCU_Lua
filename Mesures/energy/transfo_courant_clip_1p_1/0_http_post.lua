-- Petit script pour envoyer en // es valeurs sur un serveur WEB (InfluxDB)
-- via un http POST à travers un FIFO

if verbose then print("\n 0_http_post.lua   zf200610.1822   \n") end

t_zurl={}  t_zarg={} f_zpost=false

function tprint(t)    
   for key,value in pairs(t) do  print(key, value)  end
end

function zpost()
    f_zpost=true  zurl=t_zurl[1]  zarg=t_zarg[1]
    zarg=zarg.."\n".."energy,value=nb_waiting_"..yellow_id.." val="..#t_zurl
    zarg=zarg.."\n".."energy,memory=zpost_"..yellow_id.." ram="..node.heap()
            
    if verbose then print("zurl: "..zurl) end   if verbose then print("zarg: "..zarg) end
    
    http.post(zurl, 'Content-Type: application/x-www-form-urlencoded\r\n', zarg, function(code, data)
        if (code < 0) then
            print("HTTP request failed")
            print("zuzu", code, data)
        else
            if verbose then print(code, data) end
        end
    
        table.remove(t_zurl, 1)  table.remove(t_zarg, 1)
        if t_zurl[1]==nil then
            f_zpost=false
        else
            zpost()
        end
        if verbose then print("End zpost:") end
        collectgarbage()
        if verbose then print(node.heap()) end
    
    end)
    
    zurl=nil   zarg=nil
end

function http_post(zurl,zarg)
    if #t_zurl <=10 then   table.insert(t_zurl, zurl)  table.insert(t_zarg, zarg)   end
    if verbose then  print("Nb wait: "..#t_zurl)  print(node.heap())  end
    if verbose then  print("t_zurl:")  tprint(t_zurl)   print("t_zarg:")  tprint(t_zarg)  end
    if f_zpost==false then zpost() end
    if verbose then print("End http_post:") end
    collectgarbage()
    if verbose then print(node.heap()) end
end
