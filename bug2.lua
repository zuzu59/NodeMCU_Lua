
duration1 = 300    --> en ms
duration2 = 1000    --> en ms


function LED1 ()
    print("led1")
end

function LED2 ()
    print("led2")
end


tmr.alarm(1, duration1, tmr.ALARM_AUTO, LED1)
--tmr.alarm(2, duration2, tmr.ALARM_AUTO, LED2)