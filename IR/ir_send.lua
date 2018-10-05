-- Script pour la gestion de l'émetteur IR à 38kHz (LED, infrared, infrarouge)
-- permet l'envoi d'un code (4bits seulement) avec le protocole zIR, protocole de mon invention ;-)
-- exprès pas standard afin de ne pas être parasité par les autres sources IR !
-- ATTENTION, on utilise ici l'astuce du gpio.serout pour faire la pulse de 26uS (38kHz),
-- car on n'arrive pas avec le gpio.write à faire une pulse plus courte que 400uS

print("\n ir_send.lua  zf180918.1826  \n")

pin_ir_send = 7
gpio.mode(pin_ir_send,gpio.OUTPUT)
gpio.write(pin_ir_send,gpio.HIGH)

Mark_Coeff = 0.5
-- en mS/uS
Mark_Start = 3 *Mark_Coeff *1000
Mark_Bit1 = 2 *Mark_Coeff *1000
Mark_Bit0 = 1 *Mark_Coeff *1000
Mark_Space = 0.5 *Mark_Coeff *1000

-- envoi une série de pulses à 38kHz de durée zduration en uS
function pulse_ir(zduration)
--    print("pulse: "..zduration)
    gpio.serout(pin_ir_send,gpio.LOW,{1,25},zduration/26)
end

-- attention, 4 bits seulement
function send_code_ir(zcode)
    pulse_ir(Mark_Start)
    print("Mark_Space:"..Mark_Space)
    tmr.delay(Mark_Space)
    for i=0, 3 do
        if bit.isset(zcode,i) then
--            print("bit: "..i..",1")
            pulse_ir(Mark_Bit1)
        else
--            print("bit: "..i..",0")
            pulse_ir(Mark_Bit0)
        end
--        print("Mark_Space:"..Mark_Space)
        tmr.delay(Mark_Space)
    end
end


sendir_tmr1=tmr.create()
tmr.alarm(sendir_tmr1, 1000, tmr.ALARM_AUTO, function()
    send_code_ir(0x05)
end)



