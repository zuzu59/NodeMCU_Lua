--Script de bootstrap, test au moment du boot qui a été la cause de boot.
-- Si la cause est un power on ou une connexion depuis l'IDE, alors
-- le script repair.lua pendant 30 secondes avant de continuer

print("\n init.lua zf181119.2314 \n")

_, reset_reason = node.bootreason()
print("reset_reason:",reset_reason)
if reset_reason == 0 or reset_reason == 6 then
    print("seconde chance...")
    f= "repair.lua"   if file.exists(f) then dofile(f) end
    initalarme=tmr.create()
    tmr.alarm(initalarme, 300*1000,  tmr.ALARM_SINGLE, function()
        f= "boot.lua"   if file.exists(f) then dofile(f) end
    end)
else
        f= "boot.lua"   if file.exists(f) then dofile(f) end
end
