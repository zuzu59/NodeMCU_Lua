-- Petit script pour faire office de crontab pour les mesures de température
print("\n 0_cron.lua   zf200115.1704   \n")

cron1=tmr.create()
cron1:alarm(20*1000,  tmr.ALARM_AUTO, function()
    print("cron1........................")
    ztemp1=readTemp()
    zhum1=readHumi()
    print("Temperature: "..ztemp1.." °C")
    print("Humidity: "..zhum1.." %")
    zurl=thingspeak_url.."field1="..tostring(ztemp1).."&field2="..tostring(zhum1)
    send_temp()
end)


    
