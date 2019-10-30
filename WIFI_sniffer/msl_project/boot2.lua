-- Scripts à charger après le boot pour démarrer son projet

print("\n boot2.lua zf191030.1958 \n")

function boot2()

    second_chance=nil
    
    f= "flash_led_xfois.lua"   if file.exists(f) then dofile(f) end

    if false then
        tmr.create():alarm(1*1000,  tmr.ALARM_AUTO, function()
            xfois =2
            blink_LED ()
        end)
    end
    
    
    wifitimer1=tmr.create()
    wifitimer1:alarm(1*1000, tmr.ALARM_AUTO , function()
        if wifi.sta.getip() == nil then
            print("Connecting to AP...")
            xfois =2   blink_LED ()
        else
            wifitimer1:unregister()
            flash_led_xfois=nil   blink_LED=nil   ztmr_Flash_LED=nil
            zTm_Off_LED=nil  zTm_On_LED=nil  nbfois=nil  xfois=nil  zLED=nil
    
            wifi_init=nil
            cli_ssid=nil
            cli_pwd=nil
            ap_ssid=nil
            ap_pwd=nil
    
            
            
            f= "wifi_info.lua"   if file.exists(f) then dofile(f) end
            f= "secrets_project.lua"    if file.exists(f) then dofile(f) end
            f= "set_time.lua"   if file.exists(f) then dofile(f) end
            collectgarbage()
    --        f= "b.lua"   if file.exists(f) then dofile(f) end
    
            f=nil
        end
    end)
    
    tmr.create():alarm(3*1000,  tmr.ALARM_SINGLE, function()
        boot2=nil
    end)

end

boot2()


--[[
tmr.create():alarm(1*1000,  tmr.ALARM_AUTO, function()
    print(node.heap())
end)
]]


heartbeat=nil
--heartbeat()


--[[
for k,v in pairs(_G) do print(k,v) end
]]

