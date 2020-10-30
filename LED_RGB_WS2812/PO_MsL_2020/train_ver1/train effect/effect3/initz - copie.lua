--Script de bootstrap, test au moment du boot qui a été la cause de boot.
-- Si la cause est un power on ou une connexion depuis l'IDE, alors
-- le script repair.lua pendant 30 secondes avant de continuer
--Source: https://nodemcu.readthedocs.io/en/master/en/modules/node/#nodebootreason

print("\n init.lua zf181125.1340 \n")

_, reset_reason = node.bootreason()
print("reset_reason:",reset_reason)
if reset_reason == 6 or reset_reason == 6 then
    print("seconde chance...")
    f= "repair.lua"   if file.exists(f) then dofile(f) end
    initalarme=tmr.create()
    tmr.alarm(initalarme, 8*1000,  tmr.ALARM_SINGLE, function()
        f= "boot.lua"   if file.exists(f) then dofile(f) end
    end)
else
        f= "boot.lua"   if file.exists(f) then dofile(f) end
end
