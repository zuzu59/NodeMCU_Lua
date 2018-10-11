--Programme qui démarre le robot en appuyant sur le bouton flash et le redémarre si le bouton flash est appuyer pendant 3 secondes

print("\n init.lua hv180906.1450\n")

zswitch=3     --switch flash
gpio.mode(zswitch, gpio.INT, gpio.PULLUP)
initalarme=tmr.create()

function hvbouton()
    gpio.trig(zswitch, "none")
    tmr.unregister(initalarme)
    dofile("start_boot.lua")
    dofile("start_job.lua")
end

--gpio.trig(zswitch, "both", hvbouton)

tmr.alarm(initalarme, 8000,  tmr.ALARM_SINGLE, function()
    print("\nStart\n")
    dofile("start_boot.lua")
--    dofile("start_job.lua")
end)
