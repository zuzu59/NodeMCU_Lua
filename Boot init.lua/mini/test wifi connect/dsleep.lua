-- Teste le deep sleep !
-- après x seconde, s'endore pendant y secondes
-- ATTENTION: il faut connecter, avec une résistance de 1k, la pin 0 à la pin RESET !

print("\n dsleep.lua   zf181119.2343   \n")

ztmr_SLEEP = tmr.create()

function dsleep()
    tmr.alarm(ztmr_SLEEP, x_dsleep*1000, tmr.ALARM_SINGLE, function ()
        print("Je dors...")
        node.dsleep(y_dsleep*1000*1000)
    end)
end