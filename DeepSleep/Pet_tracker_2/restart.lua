-- Scripts pour faire un soft reset

print("\n restart.lua zf181209.1753 \n")

restarttimer1=tmr.create()
tmr.alarm(restarttimer1, 2*1000,  tmr.ALARM_SINGLE, function()
    node.restart()
end)

print("hello zuzu")


