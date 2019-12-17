-- Scripts à charger après le boot pour démarrer son projet

print("\n boot2.lua zf191217.2224 \n")

function boot2()
    second_chance=nil   initz=nil   boot=nil
    f= "flash_led_xfois.lua"   if file.exists(f) then dofile(f) end
    if false then
        tmr.create():alarm(1*1000,  tmr.ALARM_AUTO, function()
            xfois =2
            blink_LED ()
        end)
    end

    boot2_tmr=tmr.create()
    boot2_tmr:alarm(1*1000, tmr.ALARM_AUTO , function()
        if wifi.sta.getip() == nil then
            print("Connecting to AP...")
            xfois =2   blink_LED ()
        else
            boot2_tmr:unregister()
            flash_led_xfois=nil   blink_LED=nil   ztmr_Flash_LED=nil
            zTm_Off_LED=nil  zTm_On_LED=nil  nbfois=nil  xfois=nil  zLED=nil
            boot2_tmr=nil  secrets_wifi=nil  wifi_init=nil
            cli_ssid=nil  cli_pwd=nil  ap_ssid=nil  ap_pwd=nil
            f= "wifi_info.lua"   if file.exists(f) then dofile(f) end
            f= "secrets_project.lua"    if file.exists(f) then dofile(f) end
            f= "set_time.lua"   if file.exists(f) then dofile(f) end
            collectgarbage()
            f= "0_htu21d.lua"   if file.exists(f) then dofile(f) end
            f= "0_send_data.lua"   if file.exists(f) then dofile(f) end
            f= "0_cron.lua"   if file.exists(f) then dofile(f) end
            f= "web_srv2.lua"   if file.exists(f) then dofile(f) end

            f=nil

            verbose = true
            
            tmr.create():alarm(3*1000,  tmr.ALARM_SINGLE, function()
            print("BOOOOUM, y'a plus de boot2 !")
                wifi_info=nil   boot2=nil
            end)
        end
    end)
end

boot2()


--[[
tmr.create():alarm(1*1000,  tmr.ALARM_AUTO, function()
    print(node.heap())
end)
]]

--[[
for k,v in pairs(_G) do print(k,v) end
]]
