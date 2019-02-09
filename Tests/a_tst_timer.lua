-- Scripts pour tester le timer dans sa plus simple expression

print("\n a_tst_timer.lua zf190209.1519 \n")


test_1=tmr.create()
tmr.alarm(test_1, 1*1000,  tmr.ALARM_AUTO, function()
--tmr.alarm(test_1, 2.5*1000,  tmr.ALARM_SINGLE, function()
    print("coucou")
end)

--[[
tmr.stop(test_1)
tmr.start(test_1)
]]
