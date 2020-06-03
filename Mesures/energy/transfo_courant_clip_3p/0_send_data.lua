-- Petit script pour envoyer les valeurs sur un serveur WEB (InfluxDB)
-- via un http GET
print("\n 0_send_data.lua   zf191228.2310   \n")

function zpost(zarg)
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
end

function send_data()
    if verbose then print("send_data: ") end
    ztemp = readTemp()   zhumd = readHumi()
    if verbose then print("Temperature: "..ztemp.." °C") end
    if verbose then print("Humidity: "..zhumd.." %") end

    --zpost("bolo_ruru,capteur=th"..node_id.." humidity="..zhumd)
    --zpost("bolo_ruru,capteur=th"..node_id.." temperature="..ztemp)

--    print("titi")
end

--[[
verbose=true
send_data()
]]
