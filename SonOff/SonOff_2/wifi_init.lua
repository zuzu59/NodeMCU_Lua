-- Petit script pour initaliser la couche WIFI

function wifi_init()
    print("\n wifi_init.lua   zf200105.2355   \n")
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
    wifi_init2:alarm(120*1000,  tmr.ALARM_SINGLE, function()
        print("BOOOOUM, y'a plus de AP WIFI !")
        wifi.setmode(wifi.STATION,true)   wifi_init2=nil
        print(node.heap())   collectgarbage()   print(node.heap())
    end)

    --zLED=4      -- NodeMCU
    zLED=7      -- SonOff
    gpio.write(zLED, gpio.HIGH)   gpio.mode(zLED, gpio.OUTPUT)
    i=1
    wifi_init1=tmr.create()
    wifi_init1:alarm(1*1000, tmr.ALARM_AUTO , function()
        gpio.write(zLED, gpio.LOW)   tmr.delay(10000)   gpio.write(zLED, gpio.HIGH)
        if wifi.sta.getip() == nil then
            print("Connecting to AP...")
            i=i+1
            if i > 5 then
                i=nil   wifi_init1:unregister()
                print("pas glop :-(")

                wifi_init2:unregister()
                wifi.setmode(wifi.SOFTAP,true)
                
                f= "wifi_info.lua"   if file.exists(f) then dofile(f) end
                boot2_go = true
                
                --enduser_setup.start(function()
                --    node.restart()
                --end)
            end
        else
            wifi_init1:unregister()   zLED=nil   i=nil
            f= "wifi_info.lua"   if file.exists(f) then dofile(f) end
            boot2_go = true
        end
    end)
end

wifi_init()
