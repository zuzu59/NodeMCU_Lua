-- Petit script pour envoyer les valeurs sur un serveur WEB (InfluxDB)
-- via un http GET

function send_data()
    if verbose then print("\n 0_send_data.lua   zf200523.1643   \n") end

    function zpost(zarg)
        if verbose then print("influxdb_url: "..influxdb_url) end
        if verbose then print("zarg: "..zarg) end
        http.post(influxdb_url, 'Content-Type: application/x-www-form-urlencoded\r\n', zarg, function(code, data)
       -- print("toto")
        if (code < 0) then
            print("HTTP request failed")
            print("zuzu", code, data)
        else
            if verbose then print(code, data) end
        end
       -- print("tutu")
        end)
    end

    zpost("energy,capteur=th"..th_id.." humidity="..zhum1)
    zpost("energy,capteur=th"..th_id.." temperature="..ztemp1)

    zarg=nil  code=nil data=nil zpost=nil send_data=nil
    -- print("titi")
end

--send_data()

--[[
verbose=true
send_data()
]]
