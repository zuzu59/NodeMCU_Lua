-- Petit script pour faire office de crontab pour les mesures
print("\n 0_cron.lua   zf200524.1246   \n")


function tprint(t)    
   for key,value in pairs(t) do
       print(key, value)
   end
end

ztemp1=20  zhum1=40   ztemp2=20  zhum2=40


cron1=tmr.create()
cron1:alarm(5*1000,  tmr.ALARM_AUTO, function()
    if verbose then print("cron1........................") end
    if verbose then gpio.write(zLED, gpio.LOW) tmr.delay(10000) gpio.write(zLED, gpio.HIGH) end

    f = "0_1_htu21d.lua"  if file.exists(f) then dofile(f) end
    f = "0_2_htu21d.lua"  if file.exists(f) then dofile(f) end
    


    http_post(influxdb_url,"energy,capteur=th1 humidity="..ztemp1)
    http_post(influxdb_url,"energy,capteur=th1 humidity="..zhum1)
    http_post(influxdb_url,"energy,capteur=th1 humidity="..ztemp2)
    http_post(influxdb_url,"energy,capteur=th1 humidity="..zhum2)
    
    
    
    

    table.remove(t_zurl, 1)  table.remove(t_zarg, 1)
    print("t_zurl:")  tprint(t_zurl)   print("t_zarg:")  tprint(t_zarg)

    
    f = "0_send_data.lua" if file.exists(f) then dofile(f) end
    ztemp1=nil  zhum1=nil  ztemp2=nil  zhum2=nil
    f = "0_zdyndns.lua"   if file.exists(f) then dofile(f) end

    if verbose then print("End cron:\n"..node.heap()) end
    collectgarbage()
    if verbose then print(node.heap()) end
end)

--[[
cron1:stop()
cron1:start()
]]
