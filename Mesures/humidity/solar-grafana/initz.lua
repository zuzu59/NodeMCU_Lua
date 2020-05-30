--Script de bootstrap, test au moment du boot qui a été la cause de boot.
-- Si la cause est un power on ou une connexion depuis l'IDE, alors
-- le script repair.lua pendant xx secondes avant de continuer
--Source: https://nodemcu.readthedocs.io/en/master/en/modules/node/#nodebootreason

print("\n init.lua zf200530.1207 \n")

function initz()

    function initz_end()
        print("initz_end...")
        f= "wifi_init.lua"   if file.exists(f) then dofile(f) end
        f=nil initz=nil second_chance=nil hvbouton=nil initz_end=nil
        print(node.heap())   collectgarbage()   print(node.heap())
        print("initz_end out...")
    end

    function hvbouton()
        gpio.trig(zswitch, "none")   zswitch=nil
        print("hvbouton...")
        print(tmr.now())
        
        
        
        if tmr.now() > 5000000 then
            file.putcontents("_setup_wifi_", "toto")
            print("on demande le setup wifi !")
        end
        
        
        
        initalarme1:unregister() initalarme1=nil second_chance=nil
        gpio.write(zLED, gpio.HIGH)   zLED=nil
        reset_reason="hvbouton"
        initz_end()
    end

    function second_chance()
        print("seconde chance...")
        zLED=4      -- NodeMCU
        --zLED=7      -- SonOff
        gpio.write(zLED, gpio.LOW)   gpio.mode(zLED, gpio.OUTPUT)
        initalarme1=tmr.create()
        initalarme1:alarm(10*1000,  tmr.ALARM_SINGLE, function()
            gpio.write(zLED, gpio.HIGH)   zLED=nil
            gpio.trig(zswitch, "none")   zswitch=nil
            reset_reason="seconde_chance"
            initz_end()
        end)
        zswitch=3     --switch flash ou SonOff
        gpio.mode(zswitch, gpio.INT, gpio.PULLUP)
        gpio.trig(zswitch, "both", hvbouton)
    end

    _, reset_reason = node.bootreason()
    print("reset_reason: ",reset_reason)
    if reset_reason == 0 then
        print("power on")
        second_chance()
    elseif reset_reason == 4 then
        print("node.restart")
        initz_end()
    elseif reset_reason == 5 then
        print("dsleep wake up")
        initz_end()
    elseif reset_reason == 6 then
        print("external reset")
        second_chance()
    else
        print("autre raison")
        second_chance()
    end
end
initz()

--[[
zLED=7
gpio.mode(zLED, gpio.OUTPUT)
gpio.write(zLED, gpio.LOW)			-- actif !
gpio.write(zLED, gpio.HIGH)

zBTN=3
gpio.mode(zBTN, gpio.INPUT)
print(gpio.read(zBTN))

zRELAY=6
gpio.mode(zRELAY, gpio.OUTPUT)
gpio.write(zRELAY, gpio.HIGH)		-- actif !
gpio.write(zRELAY, gpio.LOW)
]]
