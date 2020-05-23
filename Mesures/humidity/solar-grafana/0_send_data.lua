-- Petit script pour envoyer les valeurs sur un serveur WEB (InfluxDB)
-- via un http GET

function send_data()
    if verbose then print("\n 0_send_data.lua   zf200523.1816   \n") end

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
        zarg=nil  code=nil data=nil zpost=nil send_data=nil
        if verbose then print("End send_data:\n"..node.heap()) end
        collectgarbage()
        if verbose then print(node.heap()) end

       -- print("tutu")
        end)
    end

    zarg=      "energy,capteur=th1 humidity="..zhum1.."\n"
    zarg=zarg.."energy,capteur=th1 temperature="..ztemp1.."\n"
    zarg=zarg.."energy,capteur=th2 humidity="..zhum2.."\n"
    zarg=zarg.."energy,capteur=th2 temperature="..ztemp2
    zpost(zarg)
    -- print("titi")
end

send_data()

--[[
verbose=true
send_data()
]]
