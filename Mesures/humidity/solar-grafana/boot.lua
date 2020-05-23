-- Scripts à charger après le boot pour démarrer son projet

print("\n boot.lua zf200523.1611 \n")

function boot()
    verbose = true
    print("On lance le boot...")
    print(node.heap()) collectgarbage() print(node.heap())
    --f="0_tst3_socat.lua"   if file.exists(f) then dofile(f) end
    --f="0_btn_flipflop.lua"   if file.exists(f) then dofile(f) end
    --f="0_cron.lua"   if file.exists(f) then dofile(f) end

    --f = "web_ide2.lua"   if file.exists(f) then dofile(f) end
    print("verbose:",verbose)
    print("boot lancé...")
    print(node.heap()) collectgarbage() print(node.heap())
    f=nil boot=nil
end
boot()