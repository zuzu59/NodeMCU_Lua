-- Petit script pour envoyer les valeurs de température sur un serveur WEB via un http GET
print("\n 0_send_temp.lua   zf190806.1541   \n")

function send_temp()
    print("send_web_temp: ")

    zurl="http://www.xxx.ml:8086/write?db=xxx&u=admin&p=xxx"
    print("zurl: "..zurl)

    zarg="energy,compteur=1 puissance="..zpuissance
    print("zarg: "..zarg)

 

    http.post(zurl, 'Content-Type: application/x-www-form-urlencoded\r\n', zarg, function(code, data)
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
