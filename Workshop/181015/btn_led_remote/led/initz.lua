--Script de bootstrap, en appuyant sur le bouton ça démarre start_boot,
-- autrement en attendant 8 secondes cela démarre start_boot

print("\n init.lua zf181017.1026\n")

zswitch=3     --switch flash
gpio.mode(zswitch, gpio.INT, gpio.PULLUP)
initalarme=tmr.create()

function hvbouton()
    gpio.trig(zswitch, "none")
    tmr.unregister(initalarme)
    dofile("start_boot.lua")
--    dofile("start_job.lua")
end

gpio.trig(zswitch, "both", hvbouton)

tmr.alarm(initalarme, 8000,  tmr.ALARM_SINGLE, function()
    print("\nStart\n")
    dofile("start_boot.lua")
--    dofile("start_job.lua")
end)
