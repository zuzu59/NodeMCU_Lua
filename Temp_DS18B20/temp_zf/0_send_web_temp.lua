-- Petit script pour envoyer les valeurs de température sur un serveur WEB via un HTTP GET
print("\n send_web_temp.lua   zf190726.1931   \n")

function send_temp(zserver)
    print("send_web_temp: ")

    ztemp1=11    ztemp2=12    ztemp3=13
    
    zurl=zserver.."field1="..tostring(ztemp1).."&field2="..tostring(ztemp2).."&field3="..tostring(ztemp3)
    print(zurl)

--[[
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
]]

end

--disp_send()


--[[

send_temp(concentrator_url)

]]
