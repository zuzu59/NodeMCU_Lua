-- Teste le deep sleep !
-- s'endore pendant 3 secondes après 8 secondes
-- à mettre à la place du init.lua !

-- ATTENTION: il faut connecter la pin 0 à la pin RESET !

print("\n dsleep.lua   zf181118.21227   \n")

_, reset_reason = node.bootreason()
print("reset_reason: ",reset_reason)
if reset_reason == 4 then print("Coucou, soft reset...") end
if reset_reason == 5 then print("Coucou, je suis réveillé...") end
if reset_reason == 6 then print("Coucou, hard reset...") end

ztmr_SLEEP = tmr.create()
tmr.alarm(ztmr_SLEEP, 10*1000, tmr.ALARM_SINGLE, function ()
    print("Je dors...")
    node.dsleep(10*1000*1000)
end)
