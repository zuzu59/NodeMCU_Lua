-- Petit script pour faire office de crontab pour les mesures
print("\n 0_cron.lua   zf200229.1557   \n")

cron1=tmr.create()
cron1:alarm(60*1000,  tmr.ALARM_AUTO, function()
    if verbose then print("cron1........................") end
    if verbose then gpio.write(zLED, gpio.LOW) tmr.delay(10000) gpio.write(zLED, gpio.HIGH) end

    f = "0_zdyndns.lua"   if file.exists(f) then dofile(f) end

--[[
f = "0_htu21d.lua"   if file.exists(f) then dofile(f) end

    zurl = thingspeak_url.."field1="..tostring(ztemp1).."&field2="..tostring(zhum1)

    f = "0_send_data.lua"   if file.exists(f) then dofile(f) end

    ztemp1=nil zhum1=nil
]]

    if verbose then print(node.heap()) end
    collectgarbage()
    if verbose then print(node.heap()) end
end)
