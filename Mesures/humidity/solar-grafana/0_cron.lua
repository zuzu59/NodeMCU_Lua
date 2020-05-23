-- Petit script pour faire office de crontab pour les mesures
print("\n 0_cron.lua   zf200523.1644   \n")

cron1=tmr.create()
cron1:alarm(5*1000,  tmr.ALARM_AUTO, function()
    if verbose then print("cron1........................") end
    if verbose then gpio.write(zLED, gpio.LOW) tmr.delay(10000) gpio.write(zLED, gpio.HIGH) end

    f = "0_zdyndns.lua"   if file.exists(f) then dofile(f) end

    print("toto0")
    th_id=1
    print("toto1")
    f = "0_1_htu21d.lua"  if file.exists(f) then dofile(f) end
    print("toto2")
    readHTU21D()
    print("toto3")
    f = "0_send_data.lua" if file.exists(f) then dofile(f) end
    print("toto4")
    send_data()

    print("toto5")
    th_id=2
    print("toto6")
    f = "0_2_htu21d.lua"  if file.exists(f) then dofile(f) end
    print("toto7")
    readHTU21D()
    print("toto8")
    f = "0_send_data.lua" if file.exists(f) then dofile(f) end
    print("toto9")
    send_data()
    print("toto10")

    th_id=nil  ztemp1=nil  zhum1=nil

    if verbose then print(node.heap()) end
    collectgarbage()
    if verbose then print(node.heap()) end
end)
