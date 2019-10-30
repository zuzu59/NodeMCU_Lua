--Script de bootstrap, test au moment du boot qui a été la cause de boot.
-- Si la cause est un power on ou une connexion depuis l'IDE, alors
-- le script repair.lua pendant xx secondes avant de continuer
--Source: https://nodemcu.readthedocs.io/en/master/en/modules/node/#nodebootreason

print("\n init.lua zf191030.2015 \n")

function initz()
    zswitch=3     --switch flash
    gpio.mode(zswitch, gpio.INT, gpio.PULLUP)
    
    function hvbouton()
        gpio.trig(zswitch, "none")
        initalarme:unregister()  initalarme2:unregister()
        f= "boot.lua"   if file.exists(f) then dofile(f) end
        f= "boot2.lua"   if file.exists(f) then dofile(f) end
    end
    
    gpio.trig(zswitch, "both", hvbouton)
    
    function second_chance()
        print("seconde chance...")
        f= "repair.lua"   if file.exists(f) then dofile(f) end
        initalarme=tmr.create()
        initalarme:alarm(4*1000,  tmr.ALARM_SINGLE, function()
            f= "boot.lua"   if file.exists(f) then dofile(f) end
        end)
        initalarme2=tmr.create()
        initalarme2:alarm(30*1000,  tmr.ALARM_SINGLE, function()
            gpio.trig(zswitch)
            hvbouton=nil
            zswitch=nil
            reset_reason=nil
            f= "boot2.lua"   if file.exists(f) then dofile(f) end
        end)
    end
    
    _, reset_reason = node.bootreason()
    print("reset_reason:",reset_reason)
    if reset_reason == 0 then
        print("power on")
        second_chance()
    elseif reset_reason == 4 then
        print("node.restart")
        gpio.trig(zswitch)
        hvbouton=nil
        second_chance=nil
        zswitch=nil
        reset_reason=nil
        f= "boot.lua"   if file.exists(f) then dofile(f) end
        f= "boot2.lua"   if file.exists(f) then dofile(f) end
    elseif reset_reason == 5 then
        print("dsleep wake up")
        f= "boot.lua"   if file.exists(f) then dofile(f) end
        f= "boot2.lua"   if file.exists(f) then dofile(f) end
    elseif reset_reason == 6 then
        print("external reset")
        second_chance()
    else
        print("autre raison")
        second_chance()
    end
end
initz()

