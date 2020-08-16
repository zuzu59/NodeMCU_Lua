-- Scripts pour scanner les AP WIFI et les enregistrer dans le log
-- https://www.epochconverter.com/

print("\n 0_wifi_scan.lua zf200816.1955 \n")

ztime2020 = 1577836800      -- Unix time pour 1.1.2020 0:0:0 GMT

-- sauvegarde les données dans la flash du NodeMCU
function save_flash(zstr_ap_wifi)
    ztime1 = tostring(rtctime.get() + 2*3600 - ztime2020)
    local zstr = ztime1..", "..zstr_ap_wifi
    if verbose then print("saving to flash: "..zstr) end
    file.open(logs_ap_wifi, "a+")   file.writeline(zstr)   file.close()
end

function listap(t)

    print("start display liste ap wifi...")
    for k,v in pairs(t) do
        local ssid, rssi, authmode, channel = string.match(v, "([^,]+),([^,]+),([^,]+),([^,]*)")
        if ssid == cli_ssid2 then 
            print("ah je vois que je dois m'arrêter...")
            zdsleep_stop =true
        elseif ssid == cli_ssid1 then 
            print("ah je vois que je dois chercher l'heure...")
            zdsleep_get_time = true
        end
        local zstr = k..', "'..ssid..'", '..rssi
        save_flash(zstr)
    end
    print("...end display")

    if zdsleep_stop then    
        node.restart()
    elseif zdsleep_get_time then
        wifi.setmode(wifi.STATION,true)
        wifi.sta.config{ssid=cli_ssid1, pwd=cli_pwd1}   wifi.sta.connect()
        gpio.write(zLED, gpio.HIGH)   gpio.mode(zLED, gpio.OUTPUT)   i=1        
        tmr_wifi_init1=tmr.create()
        tmr_wifi_init1:alarm(1*1000, tmr.ALARM_AUTO , function()
            gpio.write(zLED, gpio.LOW)   tmr.delay(10000)   gpio.write(zLED, gpio.HIGH)
            if wifi.sta.getip() == nil then
                print(i,"Connecting to AP...")
                i=i+1
                if i > 10 then
                    print("pas de wifi :-(")
                    print("pas grave, on continue le dsleep")
                    -- sauve l'heure sur la flash pour si jamais il y a un boot power on sans Internet
                    file.putcontents("_ztime_", rtctime.get())
                    dsleep_on()
                end
            else
                tmr_wifi_init1:unregister()
                rtctime.set(0)   sntp.sync(nil, nil, nil, 1)
                ztmr_set_time = tmr.create()
                ztmr_set_time:alarm(1*1000, tmr.ALARM_AUTO , function()
                    zrtc_time = rtctime.get()
                    print("je cherche l'heure: "..zrtc_time)
                    if zrtc_time > ztime2020 then
                        ztmr_set_time:unregister()
                        print("j'ai trouvé l'heure: "..zrtc_time)
                        file.putcontents("_ztime_", zrtc_time)
                        -- print(file.getcontents("_ztime_"))
                        dsleep_on()
                    end                        
                end)
            end
        end)
    else
        -- sauve l'heure sur la flash pour si jamais il y a un boot power on sans Internet
        file.putcontents("_ztime_", rtctime.get())
        dsleep_on()
    end
end

print("wifi scan...")
wifi.sta.getap(1, listap)

