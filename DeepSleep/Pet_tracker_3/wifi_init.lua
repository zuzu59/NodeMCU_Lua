-- Petit script pour initaliser la couche WIFI

function wifi_init()
    print("\n wifi_init.lua   zf200812.1938   \n")

    f= "secrets_wifi.lua"    if file.exists(f) then dofile(f) end
    f= "secrets_project.lua"    if file.exists(f) then dofile(f) end

    function wifi_init_end()
        tmr_wifi_init1:unregister()   i=nil
        f= "wifi_info.lua"   if file.exists(f) then dofile(f) end
        f=nil   secrets_wifi=nil   cli_pwd=nil   cli_ssid=nil
        tmr_wifi_init1=nil   wifi_init=nil
        print(node.heap()) collectgarbage() print(node.heap())
        -- f= "telnet_srv2.lua"   if file.exists(f) then dofile(f) end
        
        f="0_tst5_socat.lua"   if file.exists(f) then dofile(f) end
        
        -- f= "web_srv2.lua"   if file.exists(f) then dofile(f) end
        print(node.heap()) collectgarbage() print(node.heap())
        zdelay=1   if reset_reason=="seconde_chance" then zdelay=20 end
        tmr_wifi_init3=tmr.create()
        tmr_wifi_init3:alarm(zdelay*1000, tmr.ALARM_SINGLE, function()
            gpio.write(zLED, gpio.LOW)
            f= "boot.lua"   if file.exists(f) then dofile(f) end
            tmr_wifi_init3:unregister() tmr_wifi_init3=nil wifi_init_end=nil
            reset_reason=nil zdelay=nil
        end)
    end

    if file.exists("_setup_wifi_") then
        print("dsleep wake up")
        file.remove("_setup_wifi_")
        f = "0_dsleep2.lua"   if file.exists(f) then dofile(f) end

        -- 
        -- print("setup wifi...")
        -- file.remove("_setup_wifi_")
        -- wifi.sta.config{ssid="", pwd=""}   wifi.sta.connect()
        -- if zLED == nil then zLED = 4 end
        -- gpio.write(zLED, gpio.HIGH)   gpio.mode(zLED, gpio.OUTPUT)
        -- tmr_wifi_init4=tmr.create()
        -- tmr_wifi_init4:alarm(0.1*1000, tmr.ALARM_AUTO , function()
        --     gpio.write(zLED, gpio.LOW)   tmr.delay(10000)   gpio.write(zLED, gpio.HIGH)
        -- end)
        -- tmr.create():alarm(90*1000,  tmr.ALARM_SINGLE, function()
        --     node.restart()
        -- end)
        -- enduser_setup.start(function()
        --     print("on est sortit du setup wifi et on restart !")
        --     node.restart()
        -- end)
        -- print("setup gadget lancé...")


    else
        wifi.setmode(wifi.STATION,true)
        wifi.sta.config{ssid=cli_ssid, pwd=cli_pwd}   wifi.sta.connect()

        -- wifi.setmode(wifi.STATIONAP,true)
        -- if node_id == nil then node_id = "generic" ap_pwd = "12345678" end
        -- wifi.ap.config({ ssid = ap_ssid.."_"..node_id, pwd = ap_pwd, save=true })
        -- ap_ssid=nil  ap_pwd=nil
        -- tmr_wifi_init2=tmr.create()
        -- tmr_wifi_init2:alarm(60*1000, tmr.ALARM_SINGLE, function()
        --     print("BOOOOUM, y'a plus de AP WIFI !")
        --     wifi.setmode(wifi.STATION,true)   tmr_wifi_init2=nil
        --     print(node.heap()) collectgarbage() print(node.heap())
        -- end)
        
        gpio.write(zLED, gpio.HIGH)   gpio.mode(zLED, gpio.OUTPUT)   i=1
        tmr_wifi_init1=tmr.create()
        tmr_wifi_init1:alarm(1*1000, tmr.ALARM_AUTO , function()
            gpio.write(zLED, gpio.LOW)   tmr.delay(10000)   gpio.write(zLED, gpio.HIGH)
            if wifi.sta.getip() == nil then
                print(i,"Connecting to AP...")
                i=i+1
                if i > 30 then
                    print("pas de wifi :-(")
                    file.putcontents("_setup_wifi_", "toto")
                    print("on restart pour le setup wifi")
                    node.restart()
                    --tmr_wifi_init2:unregister()   tmr_wifi_init2=nil
                    --wifi.setmode(wifi.SOFTAP,true)
                    --wifi_init_end()
                end
            else
                wifi_init_end()
            end
        end)
    end
end

wifi_init()

--[[
file.putcontents("_setup_wifi_", "toto")
file.remove("eus_params.lua")
]]
