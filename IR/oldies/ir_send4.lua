-- Petit script pour faire clignoter la LED IR à 38kHz
-- ATTENTION, on utilise ici l'astuce du gpio.serout pour faire la pulse,
-- car on n'arrive pas avec le gpio.write à faire une pulse plus courte que 400uS

print("\n ir_send4.lua  zf180915.1330  \n")

pin_ir_send = 7
gpio.mode(pin_ir_send,gpio.OUTPUT)
gpio.write(pin_ir_send,gpio.HIGH)

function pulse_ir()
    gpio.serout(pin_ir_send,gpio.LOW,{1,25},38)
end

sendir_tmr1=tmr.create()
tmr.alarm(sendir_tmr1, 10, tmr.ALARM_AUTO, pulse_ir)
