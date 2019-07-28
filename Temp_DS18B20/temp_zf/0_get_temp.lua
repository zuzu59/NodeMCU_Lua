-- Lit le capteur de température solaire en fonction de son field qui se trouve dans les secrets !
print("\n 0_get_temp.lua zf190728.1014 \n")

-- lecture: https://thingspeak.com/channels/802784/private_show
-- source: https://nodemcu.readthedocs.io/en/master/modules/ds18b20/

local ow_pin = 3
ds18b20.setup(ow_pin)

function get_temp()
    ds18b20.read(
        function(ind,rom,res,temp,tdec,par)
            print(ind, temp, zfield)
            if zfield == 1 then
                ztemp1 = temp
                zurl=hub_url.."field1="..tostring(ztemp1)
                send_temp()
            elseif zfield == 2 then
                ztemp2 = temp
            elseif zfield == 3 then
                ztemp3 = temp
                zurl=hub_url.."field3="..tostring(ztemp3)
                send_temp()
            end
            print(ztemp1, ztemp2, ztemp3)
        end,{})
end

--[[

get_temp()

]]

