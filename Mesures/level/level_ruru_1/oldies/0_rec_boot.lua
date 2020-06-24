-- Scripts qui permet d'enregistrer la raison du boot dans la flash

-- Problématique:
-- Afin de pouvoir enregistrer l'heure du boot dans la FLASH il faut 
-- en premier récupérer l'heure sur Internet et après seulement on peut 
-- faire l'enregistrement dans la FLASH

function rec_boot()
    print("\n 0_rec_boot.lua zf200616.1400 \n")
        
    local tmr_rec_boot1=tmr.create()
    tmr_rec_boot1:alarm(1*1000,  tmr.ALARM_AUTO, function()
        if verbose then print("tmr_rec_boot1........................") end
        if verbose then gpio.write(zLED, gpio.LOW) tmr.delay(10000) gpio.write(zLED, gpio.HIGH) end
        
        if verbose   then print(rtctime.get())   end
        if verbose   then print(ztime_format(rtctime.get()+3600))   end
        
        if rtctime.get() > 0 then
            tmr_rec_boot1:unregister()
            print("Voilà on à l'heure, on peut enregistrer la raison du boot...")
            local _, zboot_reason, zboot_detail = node.bootreason()
            debug_rec("boot reason: "..zboot_reason)
            tmr_rec_boot1=nil   rec_boot=nil
            collectgarbage()   print(node.heap())
        end
        
        if verbose then print("End tmr_rec_boot1:") end
        collectgarbage()
        if verbose then print(node.heap()) end
    end)
    
end
rec_boot()


--[[
verbose = true
verbose = false
]]
