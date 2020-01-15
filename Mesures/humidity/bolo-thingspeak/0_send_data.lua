-- Petit script pour envoyer les valeurs de température sur un serveur WEB via un HTTP GET
print("\n 0_send_data.lua   zf200115.1705   \n")

function send_temp()
    print("send_web_temp: ")
    print(zurl)

    http.get(zurl, nil, function(code, data)
--            print("toto")
            if (code < 0) then
                print("HTTP request failed")
                print("zuzu", code, data)
            else
                print(code, data)
            end
--            print("tutu")
        end)
--        print("titi")
end

--[[

send_temp()

]]
