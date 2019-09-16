-- Petit script pour envoyer les valeurs sur un serveur WEB (InfluxDB)
-- via un http GET
print("\n 0_send_data.lua   zf190917.0030   \n")

function send_data()
    print("send_data: ")

    zarg="energy,compteur=2 puissance="..zpower/1000
    print("zarg: "..zarg)

    http.post(influxdb_url, 'Content-Type: application/x-www-form-urlencoded\r\n', zarg, function(code, data)
--            print("toto")
            if (code < 0) then
                print("HTTP request failed")
                print("zuzu", code, data)
            else
                print(code, data)
            end
--            print("tutu")
    end)
--    print("titi")
end

--[[
zpower=450
send_data()
]]
