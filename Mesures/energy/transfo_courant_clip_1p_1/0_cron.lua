-- Petit script pour faire office de crontab pour les mesures
print("\n 0_cron.lua   zf200621.1350   \n")

cron1=tmr.create()
cron1:alarm(10*1000,  tmr.ALARM_AUTO, function()
    -- if verbose then print("cron1........................") end
    -- if verbose then gpio.write(zLED, gpio.LOW) tmr.delay(10000) gpio.write(zLED, gpio.HIGH) end


   -- rt_launch()


    -- http_post(influxdb_url,"energy,value=test1_"..yellow_id.." val=1")
    
    -- http_post(influxdb_url,"energy,memory=cron1_"..yellow_id.." ram="..node.heap())

    -- if yellow_id == 60 then   http_post(influxdb_url,"energy,compteur=3 puissance="..zpower/1000)   end
    if yellow_id == 64 then   http_post(influxdb_url,"energy,compteur=4 puissance="..zpower/1000)   end

    -- http_post(influxdb_url,"energy,value=test2_"..yellow_id.." val=2")
    -- http_post(influxdb_url,"energy,value=test3_"..yellow_id.." val=3")
    -- http_post(influxdb_url,"energy,value=test4_"..yellow_id.." val=4")


    -- f = "0_zdyndns.lua"   if file.exists(f) then dofile(f) end
    -- f=nil
    
    -- if verbose then print("End cron:") end
    collectgarbage()
    -- if verbose then print(node.heap()) end
end)


--[[
cron1:stop()
cron1:start()
]]
