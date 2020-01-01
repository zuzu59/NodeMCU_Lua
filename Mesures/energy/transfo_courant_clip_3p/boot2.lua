-- Scripts à charger après le boot pour démarrer son projet

print("\n boot2.lua zf200101.1240 \n")

function boot2()
    print("boot2 starting...")
    second_chance=nil   initz=nil   boot=nil   zLED=nil
    boot2_tmr=nil  secrets_wifi=nil  wifi_init=nil
    cli_ssid=nil  cli_pwd=nil
    boot2_tmr1=nil   wifi_init1=nil   wifi_info=nil   boot2_go=nil
    collectgarbage()

    --f= "0_htu21d.lua"   if file.exists(f) then dofile(f) end
    --f= "0_send_data.lua"   if file.exists(f) then dofile(f) end
    --f= "0_cron.lua"   if file.exists(f) then dofile(f) end
    --f= "web_ide2.lua"   if file.exists(f) then dofile(f) end
    f=nil

    verbose = true

    boot2_tmr2=tmr.create()
    boot2_tmr2:alarm(4*1000,  tmr.ALARM_SINGLE, function()
        print("BOOOOUM, y'a plus de boot2 !")
        boot2=nil    boot2_tmr2=nil
        print(node.heap())   collectgarbage()   print(node.heap())

    --tmr.create():alarm(7*1000,  tmr.ALARM_SINGLE, function()
    --    print("MUOOOOB !")
    --    collectgarbage()
    --    print(node.heap())
        --f= "web_ide2.lua"   if file.exists(f) then dofile(f) end
    --    f=nil
    --end)
    end)
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
