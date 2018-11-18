-- Teste le deep sleep !
-- après x seconde, s'endore pendant y secondes
-- ATTENTION: il faut connecter, avec une résistance de 1k, la pin 0 à la pin RESET !

print("\n dsleep.lua   zf181119.0022   \n")

ztmr_SLEEP = tmr.create()
tmr.alarm(ztmr_SLEEP, 2*1000, tmr.ALARM_SINGLE, function ()
    print("Je dors...")
    node.dsleep(15*1000*1000)
end)
