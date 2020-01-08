-- Scripts à charger après le boot pour démarrer son projet

print("\n boot.lua zf200108.1751 \n")

function boot()

    print("booooooooooot...")
    print(node.heap()) collectgarbage() print(node.heap())

    --f= "0_htu21d.lua"   if file.exists(f) then dofile(f) end
    --f= "0_send_data.lua"   if file.exists(f) then dofile(f) end
    --f= "0_cron.lua"   if file.exists(f) then dofile(f) end
    --f= "web_ide2.lua"   if file.exists(f) then dofile(f) end
    
    f=nil boot=nil
    verbose = true

end
boot()
