-- Petit script pour faire office de crontab pour les mesures
print("\n 0_cron.lua   zf200604.1437   \n")

cron1=tmr.create()
cron1:alarm(10*1000,  tmr.ALARM_AUTO, function()
    if verbose then print("cron1........................") end
    if verbose then gpio.write(zLED, gpio.LOW) tmr.delay(10000) gpio.write(zLED, gpio.HIGH) end

    http_post(influxdb_url,"energy,memory=cron1_"..yellow_id.." ram="..node.heap())

    -- f = "0_1_htu21d.lua"  if file.exists(f) then dofile(f) end
    -- http_post(influxdb_url,"energy,capteur=th1 temperature="..ztemp1)
    -- http_post(influxdb_url,"energy,capteur=th1 humidity="..zhum1)
    -- 
    -- ztemp1=nil  zhum1=nil  ztemp2=nil  zhum2=nil

    http_post(influxdb_url,"energy,compteur=3 puissance="..zpower/1000)

    -- zarg="energy,compteur=2 puissance="..zpower/1000





    -- f = "0_zdyndns.lua"   if file.exists(f) then dofile(f) end

    f=nil
    
    if verbose then print("End cron:\n"..node.heap()) end
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
