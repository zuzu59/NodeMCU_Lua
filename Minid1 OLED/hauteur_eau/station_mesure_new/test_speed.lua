print("\n test_speed.lua  zf181026.1233  \n")

local pin_ir_send = 8
gpio.mode(pin_ir_send,gpio.OUTPUT)
local write = gpio.write
write(pin_ir_send, 0)

function pulse_ir()
    local i,a
    for i = 1,10 do

t1=tmr.now()
    
        write(pin_ir_send, 1)
--        a=1  a=1  a=1  a=1
        write(pin_ir_send, 0)
        a=1  a=1  a=1

t2=tmr.now()
print("durée: "..t2-t1-294)

    end
end

sendir_tmr1=tmr.create()
tmr.alarm(sendir_tmr1, 3000, tmr.ALARM_AUTO, pulse_ir)
