-- Petit script pour faire office de crontab pour les 
--mesures
print("\n 0_cron.lua   zf190916.2318   \n")

    cron1=tmr.create()
    cron1:alarm(5*1000,  tmr.ALARM_AUTO, function()
        send_data()
    end)
