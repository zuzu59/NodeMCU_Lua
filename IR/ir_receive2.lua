-- Petit script pour recevoir la LED IR 

print("\n ir_receive2.lua  zf180909.1936  \n")


pin_hp = 8
gpio.mode(pin_hp,gpio.OUTPUT)
gpio.write(pin_hp,gpio.LOW)

pin_ir_receive = 7
gpio.mode(pin_ir_receive, gpio.INT, gpio.PULLUP)

function pulse_detected()
    gpio.write(pin_hp,gpio.HIGH)
    tmr.delay(900)
    --print("pulse")
    gpio.write(pin_hp,gpio.LOW)
end

gpio.trig(pin_ir_receive,"down",pulse_detected)


--adctimer1=tmr.create()
--tmr.alarm(adctimer1, 50, tmr.ALARM_AUTO, function()
--    print(adc.read(0))
--end)
