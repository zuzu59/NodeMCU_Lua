-- Petit script pour faire office de crontab pour les mesures de température
print("\n 0_cron_temp.lua   zf190728.1054   \n")

    cron1=tmr.create()
    cron1:alarm(10*1000,  tmr.ALARM_AUTO, function()
        get_temp()
    end)

    if zfield == 2 then
        cron2=tmr.create()
        cron2:alarm(20*1000,  tmr.ALARM_AUTO, function()
            print("cron2........................")
            zurl=thingspeak_url.."field1="..tostring(ztemp1).."&field2="..tostring(ztemp2).."&field3="..tostring(ztemp3)
            send_temp()
        end)
    end


    
