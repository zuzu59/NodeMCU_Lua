-- Petit script pour faire clignoter la LED IR à 38kHz
-- ATTENTION, on utilise ici une superbe astuce pour faire la pulse, on 
-- précharge dans une variable locale le gpio.write, car on n'arrive pas avec 
-- le gpio.write à  faire une pulse plus courte que 400uS

print("\n ir_send3.lua  zf180909.1256  \n")

local pin_ir_send = 8
gpio.mode(pin_ir_send,gpio.OUTPUT)
local write = gpio.write
write(pin_ir_send, 0)

function pulse_ir()
    local i,a
    for i = 1,10 do
        write(pin_ir_send, 1)
        a=1  a=1  a=1  a=1
        write(pin_ir_send, 0)
        a=1  a=1  a=1
    end
end

sendir_tmr1=tmr.create()
tmr.alarm(sendir_tmr1, 1, tmr.ALARM_AUTO, pulse_ir)
