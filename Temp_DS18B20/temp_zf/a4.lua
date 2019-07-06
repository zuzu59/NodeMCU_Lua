-- programme pour faire un test depuis de le webide

function a4()
    print("\n a4.lua zf190617.1125 \n")
    
end

a4()


    cron1=tmr.create()
    cron1:alarm(20*1000,  tmr.ALARM_AUTO, function()
        f= "a2.lua"   if file.exists(f) then dofile(f) end
    end)


