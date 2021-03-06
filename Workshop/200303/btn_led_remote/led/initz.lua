-- Script de bootstrap, en appuyant sur le bouton ça démarre start_boot,
-- autrement en attendant 8 secondes cela démarre start_boot

print("\n init.lua zf200717.1625\n")

zswitch=3     --switch flash
gpio.mode(zswitch, gpio.INT, gpio.PULLUP)
initalarme=tmr.create()

function hvbouton()
    gpio.trig(zswitch, "none")
    initalarme:unregister()
    dofile("start_boot.lua")
end

gpio.trig(zswitch, "both", hvbouton)

initalarme:alarm(8000,  tmr.ALARM_SINGLE, function()
    print("\nStart\n")
    dofile("start_boot.lua")
end)
