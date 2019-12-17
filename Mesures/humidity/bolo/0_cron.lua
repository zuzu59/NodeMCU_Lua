-- Petit script pour faire office de crontab pour les 
--mesures
print("\n 0_cron.lua   zf191217.2222   \n")

f= "flash_led_xfois.lua" if file.exists(f) then dofile(f) end
flash_led_xfois()
xfois =2

cron1=tmr.create()
cron1:alarm(10*1000,  tmr.ALARM_AUTO, function()
    blink_LED ()
    send_data()
end)
