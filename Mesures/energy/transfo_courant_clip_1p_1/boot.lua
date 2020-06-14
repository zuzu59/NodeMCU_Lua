-- Scripts à charger après le boot pour démarrer son projet

print("\n boot.lua zf200614.1724 \n")

function zztime_format(ztime)
    local tm = rtctime.epoch2cal(ztime + 3600)
    return(string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"], tm["day"], tm["hour"], tm["min"], tm["sec"]))
end

function debug_rec(zdebug)
    local sec, usec = rtctime.get()
    file.open("00_debug.txt", "a+")
    file.writeline(zztime_format(sec).."."..usec..", "..zdebug)
    file.close()
end



function boot()
    verbose = false
    print("On lance le boot...")
    collectgarbage() print(node.heap())
    
    f = "0_rec_boot.lua"  if file.exists(f) then dofile(f) end
    collectgarbage() print(node.heap())
        
    f = "0_http_post.lua"  if file.exists(f) then dofile(f) end
    collectgarbage() print(node.heap())

    _, boot_reason = node.bootreason()
    zarg_boot=           "energy,memory=boot_"..yellow_id.." ram="..node.heap().."\n"
    zarg_boot=zarg_boot.."energy,value=boot_reason_"..yellow_id.." val="..boot_reason
    http_post(influxdb_url,zarg_boot)
    boot_reason = nil
    
    -- f = "0_zdyndns.lua"   if file.exists(f) then dofile(f) end
    -- print(node.heap()) collectgarbage() print(node.heap())

    f="0_btn_flipflop.lua"   if file.exists(f) then dofile(f) end
    collectgarbage() print(node.heap())
    
    zpower=0
    f="0_get_power.lua"   if file.exists(f) then dofile(f) end
    collectgarbage() print(node.heap())
    
    f="0_cron.lua"   if file.exists(f) then dofile(f) end
    collectgarbage() print(node.heap())

    print("verbose:",verbose)   print("le boot est lancé...")
    gpio.write(zLED, gpio.HIGH)    
    f=nil boot=nil
    collectgarbage() print(node.heap())
end
boot()


--[[
verbose = true
verbose = false
]]
