-- Scripts à charger après le boot pour démarrer son projet


ATTENTION: n'existe plus depuis le 190108.1747 !


print("\n boot2.lua zf200106.2331 \n")

function boot2()
    print("boot2 starting...")
    boot2_tmr=nil   boot2_tmr1=nil   boot2_go=nil
    print(node.heap())   collectgarbage()   print(node.heap())

    --f= "0_htu21d.lua"   if file.exists(f) then dofile(f) end
    --f= "0_send_data.lua"   if file.exists(f) then dofile(f) end
    --f= "0_cron.lua"   if file.exists(f) then dofile(f) end
    --f= "web_ide2.lua"   if file.exists(f) then dofile(f) end
    f=nil

    verbose = true

    boot2=nil
end

boot2_tmr1=tmr.create()
boot2_tmr1:alarm(1*1000, tmr.ALARM_AUTO , function()
    if boot2_go then
        boot2_tmr1:unregister()   boot2()
    end
end)







--[[
tmr.create():alarm(1*1000,  tmr.ALARM_AUTO, function()
    print(node.heap())
end)
]]

--[[
for k,v in pairs(_G) do print(k,v) end
]]
