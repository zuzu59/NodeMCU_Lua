-- Petit script pour initaliser la couche WIFI

function wifi_init()
    print("\n wifi_init.lua   zf200110.1236   \n")

    function wifi_init_end()
        wifi_init1:unregister()   i=nil
        f= "wifi_info.lua"   if file.exists(f) then dofile(f) end
        f=nil   secrets_wifi=nil   cli_pwd=nil   cli_ssid=nil
        wifi_init1=nil   wifi_init=nil
        print(node.heap()) collectgarbage() print(node.heap())
        f= "telnet_srv2.lua"   if file.exists(f) then dofile(f) end
        f= "web_srv2.lua"   if file.exists(f) then dofile(f) end
        print(node.heap()) collectgarbage() print(node.heap())
        zdelay=1   if reset_reason=="seconde_chance" then zdelay=20 end
        wifi_init3=tmr.create()
        wifi_init3:alarm(zdelay*1000, tmr.ALARM_SINGLE, function()
            f= "boot.lua"   if file.exists(f) then dofile(f) end
            wifi_init3:unregister() wifi_init3=nil wifi_init_end=nil
            reset_reason=nil zdelay=nil
        end)
    end

    if file.exists("_setup_wifi_") then
        file.remove("_setup_wifi_")
        print("setup wifi...")
        enduser_setup.start(function()
            node.restart()
        end)
    else
        -- charge les secrets pour le wifi
        f= "secrets_wifi.lua"    if file.exists(f) then dofile(f) end
        f= "secrets_project.lua"    if file.exists(f) then dofile(f) end
        wifi.setmode(wifi.STATIONAP,true)
        wifi.sta.config{ssid=cli_ssid, pwd=cli_pwd, auto=true, save=true}
        wifi.sta.autoconnect(1)   wifi.sta.connect()
        if node_id == nil then node_id = "generic" end
        wifi.ap.config({ ssid = ap_ssid.."_"..node_id, pwd = ap_pwd, save=true })
        ap_ssid=nil  ap_pwd=nil
        wifi_init2=tmr.create()
        wifi_init2:alarm(60*1000, tmr.ALARM_SINGLE, function()
            print("BOOOOUM, y'a plus de AP WIFI !")
            wifi.setmode(wifi.STATION,true)   wifi_init2=nil
            print(node.heap()) collectgarbage() print(node.heap())
        end)

        gpio.write(zLED, gpio.HIGH)   gpio.mode(zLED, gpio.OUTPUT)   i=1
        wifi_init1=tmr.create()
        wifi_init1:alarm(1*1000, tmr.ALARM_AUTO , function()
            gpio.write(zLED, gpio.LOW)   tmr.delay(10000)   gpio.write(zLED, gpio.HIGH)
            if wifi.sta.getip() == nil then
                print("Connecting to AP...")
                i=i+1
                if i > 15 then
                    print("pas de wifi :-(")
                    wifi_init2:unregister()   wifi_init2=nil
                    wifi.setmode(wifi.SOFTAP,true)
                    wifi_init_end()
                end
            else
                wifi_init_end()
            end
        end)
    end
end

wifi_init()

--[[
file.putcontents("_setup_wifi_", "")
boot2_go = true
]]

