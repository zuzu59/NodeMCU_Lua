-- Petit script pour faire office de crontab pour les mesures
print("\n 0_cron.lua   zf200604.1313   \n")

cron1=tmr.create()
cron1:alarm(10*1000,  tmr.ALARM_AUTO, function()
    if verbose then print("cron1........................") end
    if verbose then gpio.write(zLED, gpio.LOW) tmr.delay(10000) gpio.write(zLED, gpio.HIGH) end

    http_post(influxdb_url,"energy,memory=cron1_"..yellow_id.." ram="..node.heap())
    http_post(influxdb_url,"energy,compteur=3 puissance="..zpower/1000)

    -- f = "0_zdyndns.lua"   if file.exists(f) then dofile(f) end

    f=nil
    
    if verbose then print("End cron:") end
    collectgarbage()
    if verbose then print(node.heap()) end
end)

--[[
cron1:stop()
cron1:start()

sec, usec = rtctime.get()
print(sec,usec)

print(ztime_format(rtctime.get()))



]]
