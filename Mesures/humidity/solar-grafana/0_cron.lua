-- Petit script pour faire office de crontab pour les mesures
print("\n 0_cron.lua   zf200525.1402   \n")


function tprint(t)    
   for key,value in pairs(t) do
       print(key, value)
   end
end

ztemp1=20  zhum1=40   ztemp2=20  zhum2=40


cron1=tmr.create()
cron1:alarm(10*1000,  tmr.ALARM_AUTO, function()
    if verbose then print("cron1........................") end
    if verbose then gpio.write(zLED, gpio.LOW) tmr.delay(10000) gpio.write(zLED, gpio.HIGH) end

    http_post(influxdb_url,"energy,memory=cron1 ram="..node.heap())

    f = "0_1_htu21d.lua"  if file.exists(f) then dofile(f) end
    http_post(influxdb_url,"energy,capteur=th1 temperature="..ztemp1)
    http_post(influxdb_url,"energy,capteur=th1 humidity="..zhum1)

    f = "0_2_htu21d.lua"  if file.exists(f) then dofile(f) end
    http_post(influxdb_url,"energy,capteur=th2 temperature="..ztemp2)
    http_post(influxdb_url,"energy,capteur=th2 humidity="..zhum2)

    ztemp1=nil  zhum1=nil  ztemp2=nil  zhum2=nil

    f = "0_zdyndns.lua"   if file.exists(f) then dofile(f) end

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
