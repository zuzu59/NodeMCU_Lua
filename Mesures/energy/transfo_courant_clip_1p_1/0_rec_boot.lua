-- Scripts qui permet d'enregistrer la raison du boot dans la flash

print("\n 0_rec_boot.lua zf200611.1151 \n")

-- Problématique:
-- Afin de pouvoir enregistrer l'heure du boot dans la FLASH il faut 
-- en premier récupérer l'heure sur Internet et après seulement on peut 
-- faire l'enregistrement dans la FLASH

function rec_boot()

    sntp.sync(nil, nil, nil, 1)

    function ztime_format(ztime)
        tm = rtctime.epoch2cal(ztime + 3600)
        return(string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"], tm["day"], tm["hour"], tm["min"], tm["sec"]))
    end

    tmr_rec_boot1=tmr.create()
    tmr_rec_boot1:alarm(1*1000,  tmr.ALARM_AUTO, function()
        if verbose then print("tmr_rec_boot1........................") end
        if verbose then gpio.write(zLED, gpio.LOW) tmr.delay(10000) gpio.write(zLED, gpio.HIGH) end
        
        if verbose   then print(rtctime.get())   end
        if verbose   then print(ztime_format(rtctime.get()+3600))   end

        if rtctime.get() > 0 then
            print("Voilà on à l'heure, on peut enregistrer...")
            tmr_rec_boot1:unregister()   tmr_rec_boot1=nil
            file.open("00_boot_reason.txt", "a+")
            file.writeline(ztime_format(rtctime.get()+3600))
            _, zboot_reason, zboot_detail = node.bootreason()
            file.writeline(zboot_reason,zboot_detail)            
            file.close()
            zboot_detail=nil   zboot_reason=nil
            ztime_format=nil rec_boot=nil
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
