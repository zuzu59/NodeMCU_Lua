-- Petit script pour faire office de crontab pour les mesures de température
print("\n 0_cron_temp.lua   zf190727.1336   \n")

    cron1=tmr.create()
    cron1:alarm(10*1000,  tmr.ALARM_AUTO, function()
        get_temp()
    end)


