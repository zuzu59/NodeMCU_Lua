-- Petit script pour envoyer quelque chose sur un serveur WEB
print("\n web_cli.lua   zf190616.1513   \n")


function disp_send()
    print("web_cli: ")
    ztemp1=11    ztemp2=12    ztemp3=13
    
    zurl=thingspeak_url_update.."field1="..tostring(ztemp1).."&field2="..tostring(ztemp2).."&field3="..tostring(ztemp3)
    print(zurl)
    http.get(zurl, nil, function(code, data)
        print("toto")
        if (code < 0) then
            print("tutu")
            print("HTTP request failed")
            print("zuzu", code, data)
        else
            print("titi")
            print(code, data)
        end
    end)
end

--disp_send()


--[[
disp_send()



]]
