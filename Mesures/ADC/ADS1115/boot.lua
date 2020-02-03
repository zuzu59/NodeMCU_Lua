-- Scripts à charger après le boot pour démarrer son projet

print("\n boot.lua zf200203.1423 \n")

function boot()
    verbose = true
    print("booooooooooot...")
    print(node.heap()) collectgarbage() print(node.heap())

    --f="0_htu21d.lua"   if file.exists(f) then dofile(f) end
    --zurl=thingspeak_url.."field1="..tostring(ztemp1).."&field2="..tostring(zhum1)
    --f="0_send_data.lua"   if file.exists(f) then dofile(f) end
    --f="0_cron.lua"   if file.exists(f) then dofile(f) end
    f="0_btn_flipflop.lua"   if file.exists(f) then dofile(f) end
    
    --f = "web_ide2.lua"   if file.exists(f) then dofile(f) end

    f=nil boot=nil
end
boot()
