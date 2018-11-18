-- super mini bootstrap 
print("\n init_minizf1.lua   zf180909.1112   \n")

zswitch=3     --switch flash
gpio.mode(zswitch, gpio.INT, gpio.PULLUP)
initalarme=tmr.create()

function zbutton()
    gpio.trig(zswitch, "none")
    tmr.unregister(initalarme)
    dofile("start_boot.lua")
    dofile("start_job.lua")
end

gpio.trig(zswitch, "both", zbutton)

tmr.alarm(initalarme, 8000,  tmr.ALARM_SINGLE, function()
    print("\nStart\n")
    dofile("start_boot.lua")
--    dofile("start_job.lua")
end)
