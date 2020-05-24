-- Petit script pour faire office de crontab pour les mesures
print("\n 0_cron.lua   zf200524.1224   \n")

cron1=tmr.create()
cron1:alarm(5*1000,  tmr.ALARM_AUTO, function()
    if verbose then print("cron1........................") end
    if verbose then gpio.write(zLED, gpio.LOW) tmr.delay(10000) gpio.write(zLED, gpio.HIGH) end

    f = "0_1_htu21d.lua"  if file.exists(f) then dofile(f) end
    f = "0_2_htu21d.lua"  if file.exists(f) then dofile(f) end
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