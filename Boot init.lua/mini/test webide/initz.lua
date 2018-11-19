--Script de bootstrap, test au moment du boot qui a été la cause de boot.
-- Si la cause est un power on ou une connexion depuis l'IDE, alors
-- le script repair.lua pendant 30 secondes avant de continuer

print("\n init.lua zf181119.1408 \n")

_, reset_reason = node.bootreason()
print("reset_reason:",reset_reason)
if reset_reason == 0 or reset_reason == 6 then
    print("seconde chance...")
    if file.exists("repair.lua") then dofile("repair.lua") end
    initalarme=tmr.create()
    tmr.alarm(initalarme, 300*1000,  tmr.ALARM_SINGLE, function()
        if file.exists("boot.lua") then dofile("boot.lua") end
    end)
else
        if file.exists("boot.lua") then dofile("boot.lua") end
end
