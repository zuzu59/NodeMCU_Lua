-- Scripts à charger après le boot pour démarrer son projet

print("\n boot.lua zf200603.1953 \n")

-- function ztime_stamp()  return tmr.now()/1000000  end

function boot()
    verbose = false
    print("On lance le boot...")
    print(node.heap()) collectgarbage() print(node.heap())
    
    f = "0_http_post.lua"  if file.exists(f) then dofile(f) end
    http_post(influxdb_url,"energy,memory=boot_"..yellow_id.." ram="..node.heap())
    
    -- f="0_tst3_socat.lua"   if file.exists(f) then dofile(f) end
    
    -- f = "0_zdyndns.lua"   if file.exists(f) then dofile(f) end
    -- print(node.heap()) collectgarbage() print(node.heap())

    f="0_btn_flipflop.lua"   if file.exists(f) then dofile(f) end
    -- print(node.heap()) collectgarbage() print(node.heap())

    f="0_get_power.lua"   if file.exists(f) then dofile(f) end


    -- f="0_cron.lua"   if file.exists(f) then dofile(f) end

    print("verbose:",verbose)   print("boot lancé...")
    gpio.write(zLED, gpio.HIGH)    
    f=nil boot=nil
    print(node.heap()) collectgarbage() print(node.heap())
end
boot()

--[[
verbose = true
verbose = false
]]
