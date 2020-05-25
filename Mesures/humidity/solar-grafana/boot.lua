-- Scripts à charger après le boot pour démarrer son projet

print("\n boot.lua zf200525.1229 \n")

function ztime_stamp()  return tmr.now()/1000000  end

function boot()
    verbose = true
    print("On lance le boot...")
    print("boot: "..ztime_stamp())
    print(node.heap()) collectgarbage() print(node.heap())
    
    f="0_tst3_socat.lua"   if file.exists(f) then dofile(f) end
    print(node.heap()) collectgarbage() print(node.heap())

    f = "0_http_post.lua"  if file.exists(f) then dofile(f) end
    print(node.heap()) collectgarbage() print(node.heap())

    f="0_btn_flipflop.lua"   if file.exists(f) then dofile(f) end
    print(node.heap()) collectgarbage() print(node.heap())

    f="0_cron.lua"   if file.exists(f) then dofile(f) end
    print(node.heap()) collectgarbage() print(node.heap())

    --f = "web_ide2.lua"   if file.exists(f) then dofile(f) end
    
    print("verbose:",verbose)
    print("boot lancé...")
    print("boot: "..ztime_stamp())
    print(node.heap()) collectgarbage() print(node.heap())
    f=nil boot=nil
end
boot()

--[[
verbose = true
verbose = false
]]
