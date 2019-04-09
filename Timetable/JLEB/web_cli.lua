-- Petit script pour envoyer quelque chose sur un serveur WEB
print("\n web_cli.lua   zf190408.1823   \n")


function disp_send()
--    http.get("http://192.168.4.1/?line1="..zlength.."m", nil, function(code, data)
    print("web_cli: ")
    http.get("http://transport.opendata.ch/v1/connections?from=Cheseaux&to=Lausanne-Flon&fields[]=connections/from/departure", nil, function(code, data)
        if (code < 0) then
            print("HTTP request failed")
        else
            print(code, data)
            jp= 50   h1=string.sub (data,jp,jp+7)
            jp= 100   h2=string.sub (data,jp,jp+7)
            jp= 150   h3=string.sub (data,jp,jp+7)
            jp= 200   h4=string.sub (data,jp,jp+7)
            print(h1,h2,h3,h4)
--            tm = rtctime.epoch2cal(rtctime.get() + 3600)      -- heure d'été
            tm = rtctime.epoch2cal(rtctime.get() + 7200)           -- heure d'hiver
            
            h0 = string.format("%02d:%02d:%02d", tm["hour"], tm["min"], tm["sec"])
            print("Il est "..h0)
            d1=zround((diff_time(h2, h0)/180),0)
            d2=zround((diff_time(h3, h0)/180),0)
            print(d1,d2)
            xfois1 = d2   xfois2 =d1
        end
    end)
end

disp_send()


--[[
tm = rtctime.epoch2cal(ztime + 3600)
h0 = string.format("%02d:%02d:%02d", tm["hour"], tm["min"], tm["sec"])
print(h0)


]]
