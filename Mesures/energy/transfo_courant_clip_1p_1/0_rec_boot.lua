-- Scripts qui permet d'enregistrer la raison du boot dans la flash

print("\n 0_rec_boot.lua zf200614.1735 \n")

-- Problématique:
-- Afin de pouvoir enregistrer l'heure du boot dans la FLASH il faut 
-- en premier récupérer l'heure sur Internet et après seulement on peut 
-- faire l'enregistrement dans la FLASH

function rec_boot()
    
    sntp.sync(nil, nil, nil, 1)
    
    function ztime_format(ztime)
        local tm = rtctime.epoch2cal(ztime + 3600)
        return(string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"], tm["day"], tm["hour"], tm["min"], tm["sec"]))
    end
    
    tmr_rec_boot1=tmr.create()
    tmr_rec_boot1:alarm(1*1000,  tmr.ALARM_AUTO, function()
        if verbose then print("tmr_rec_boot1........................") end
        if verbose then gpio.write(zLED, gpio.LOW) tmr.delay(10000) gpio.write(zLED, gpio.HIGH) end
        
        if verbose   then print(rtctime.get())   end
        if verbose   then print(ztime_format(rtctime.get()+3600))   end
        
        if rtctime.get() > 0 then
            print("Voilà on à l'heure, on peut enregistrer la raison du boot...")
            tmr_rec_boot1:unregister()   tmr_rec_boot1=nil
            local sec, usec = rtctime.get()
            local _, zboot_reason, zboot_detail = node.bootreason()
            file.open("00_debug.txt", "a+")
            file.writeline(string.rep(".",20))
            file.writeline(zztime_format(sec).."."..usec..", boot reason: "..zboot_reason)
            file.close()
            ztime_format=nil rec_boot=nil
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
