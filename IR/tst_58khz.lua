-- Script pour la porteuse à 58kHz
-- la gestion de l'émetteur IR à 38kHz (LED, infrared, infrarouge)
-- permet l'envoi d'un code (4bits seulement) avec le protocole zIR, protocole de mon invention ;-)
-- exprès pas standard afin de ne pas être parasité par les autres sources IR !
-- ATTENTION, on utilise ici l'astuce du gpio.serout pour faire la pulse de 26uS (38kHz),
-- car on n'arrive pas avec le gpio.write à faire une pulse plus courte que 400uS

print("\n tst_58khz.lua  zf181128.1501  \n")

pin_ir_send = 7
gpio.mode(pin_ir_send,gpio.OUTPUT)
gpio.write(pin_ir_send,gpio.HIGH)

-- envoi une série de pulses à 38kHz de durée zduration en uS
function pulse_ir(zduration)
--    print("pulse: "..zduration)
    gpio.serout(pin_ir_send,gpio.LOW,{7,7},zduration)
end

sendir_tmr1=tmr.create()
tmr.alarm(sendir_tmr1, 1000, tmr.ALARM_AUTO, function()
    --print("go")
    pulse_ir(50 *1000)
end)


