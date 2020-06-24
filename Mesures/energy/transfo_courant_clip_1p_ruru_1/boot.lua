-- Scripts à charger après le boot pour démarrer son projet

function boot()
    print("\n boot.lua zf200621.1939 \n")
    print("On lance le boot...")
    collectgarbage() print(node.heap())
    local f        
    f = "0_http_post.lua"  if file.exists(f) then dofile(f) end
    collectgarbage() print(node.heap())

    local _, boot_reason = node.bootreason()
    zarg_boot=           "energy,memory=boot_"..yellow_id.." ram="..node.heap().."\n"
    zarg_boot=zarg_boot.."energy,value=boot_reason_"..yellow_id.." val="..boot_reason
    http_post(influxdb_url,zarg_boot)
    
    -- f = "0_zdyndns.lua"   if file.exists(f) then dofile(f) end
    -- print(node.heap()) collectgarbage() print(node.heap())

    f="0_btn_flipflop.lua"   if file.exists(f) then dofile(f) end
    collectgarbage() print(node.heap())
    
    zpower=0
    f="0_get_power.lua"   if file.exists(f) then dofile(f) end
    collectgarbage() print(node.heap())
    
    f="0_cron.lua"   if file.exists(f) then dofile(f) end
    collectgarbage() print(node.heap())

    verbose = true
    print("verbose: ",verbose,"\nle boot est lancé...")
    gpio.write(zLED, gpio.HIGH)    
    f=nil boot=nil
end

-- function debug_rec(zdebug)
--     local sec, usec = rtctime.get()   local tm = rtctime.epoch2cal(sec + 2*3600)
--     local ztm = string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"], tm["day"], tm["hour"], tm["min"], tm["sec"])
--     file.open("00_debug.txt", "a+")   file.writeline(ztm.."."..usec..", "..zdebug)   file.close()
-- end
-- 
-- function rec_boot()
--     sntp.sync(nil, nil, nil, 1)     
--     tmr_rec_boot1=tmr.create()
--     tmr_rec_boot1:alarm(1*1000,  tmr.ALARM_AUTO, function()
--         print("beep...")
--         if rtctime.get() > 0 then
--             tmr_rec_boot1:unregister()   
--             print("Voilà on à l'heure, on peut enregistrer la raison du boot...")
--             local _, zboot_reason, zboot_detail = node.bootreason()
--             debug_rec("boot reason: "..zboot_reason)
--             tmr_rec_boot1=nil   rec_boot=nil
--             collectgarbage()   print(node.heap())
--         end
--     end)    
-- end

verbose=true
if rec_boot~=nil   then rec_boot()   end
boot()
collectgarbage() print(node.heap())


--[[
verbose = true
verbose = false
]]
