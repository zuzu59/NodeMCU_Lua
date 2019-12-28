-- Petit script pour faire office de crontab pour les
--mesures
print("\n 0_cron.lua   zf191225.1803   \n")

cron1=tmr.create()
cron1:alarm(300*1000,  tmr.ALARM_AUTO, function()
    send_data()
end)
