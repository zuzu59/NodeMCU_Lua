-- Petit script pour faire office de crontab pour les mesures
print("\n 0_cron.lua   zf200119.0947   \n")

cron1=tmr.create()
cron1:alarm(20*1000,  tmr.ALARM_AUTO, function()
    if verbose then print("cron1........................") end
    if verbose then gpio.write(zLED, gpio.LOW) tmr.delay(10000) gpio.write(zLED, gpio.HIGH) end
    ztemp1=readTemp()   zhum1=readHumi()
    if verbose then print("Temperature: "..ztemp1.." °C") end
    if verbose then print("Humidity: "..zhum1.." %") end
    zurl=thingspeak_url.."field1="..tostring(ztemp1).."&field2="..tostring(zhum1)
    send_temp()
    if verbose then print(node.heap()) collectgarbage() print(node.heap()) end
end)
