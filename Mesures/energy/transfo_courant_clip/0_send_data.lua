-- Petit script pour envoyer les valeurs sur un serveur WEB (InfluxDB)
-- via un http GET
print("\n 0_send_data.lua   zf190924.1043   \n")

function send_data()
    if verbose then print("send_data: ") end

    zarg="energy,compteur=2 puissance="..zpower/1000
    if verbose then print("zarg: "..zarg) end

    http.post(influxdb_url, 'Content-Type: application/x-www-form-urlencoded\r\n', zarg, function(code, data)
--            print("toto")
            if (code < 0) then
                print("HTTP request failed")
                print("zuzu", code, data)
            else
                if verbose then print(code, data) end
            end
--            print("tutu")
    end)
--    print("titi")
end

--[[
zpower=450
send_data()
]]
