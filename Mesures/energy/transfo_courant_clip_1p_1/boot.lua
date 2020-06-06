-- Scripts à charger après le boot pour démarrer son projet

print("\n boot.lua zf200606.1312 \n")

-- function ztime_stamp()  return tmr.now()/1000000  end

function boot()
    verbose = true
    print("On lance le boot...")
    collectgarbage() print(node.heap())
    
    f = "0_http_post.lua"  if file.exists(f) then dofile(f) end
    collectgarbage() print(node.heap())

    http_post(influxdb_url,"energy,memory=boot_"..yellow_id.." ram="..node.heap())
        
    -- f = "0_zdyndns.lua"   if file.exists(f) then dofile(f) end
    -- print(node.heap()) collectgarbage() print(node.heap())

    f="0_btn_flipflop.lua"   if file.exists(f) then dofile(f) end
    collectgarbage() print(node.heap())
    
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
