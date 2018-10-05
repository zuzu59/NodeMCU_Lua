-- Petit script pour recevoir la LED IR

print("\n ir_receive2.lua  zf180915.1321  \n")


pin_hp = 8
gpio.mode(pin_hp,gpio.OUTPUT)
gpio.write(pin_hp,gpio.LOW)

pin_ir_receive = 7
gpio.mode(pin_ir_receive, gpio.INT, gpio.PULLUP)

i=1  j=i

function pulse_detected()
--    gpio.write(pin_hp,gpio.HIGH)
    --tmr.delay(500)
    i=i+1
--    gpio.write(pin_hp,gpio.LOW)
end

gpio.trig(pin_ir_receive,"down",pulse_detected)

ir_receive_tmr1=tmr.create()
tmr.alarm(ir_receive_tmr1, 500, tmr.ALARM_AUTO, function()
    if i~=j then
        gpio.write(pin_hp,gpio.HIGH)
        print(i)
        j=i
        gpio.write(pin_hp,gpio.LOW)
    end
end)
