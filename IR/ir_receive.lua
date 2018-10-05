-- Script pour la gestion du récepteur IR à 38kHz (LED, infrared, infrarouge)
-- permet la réception d'un code (4bits seulement) avec le protocole zIR, protocole de mon invention ;-)
-- exprès pas standard afin de ne pas être parasité par les autres sources IR !

print("\n ir_receive.lua  zf180918.1906  \n")

pin_hp = 8
gpio.mode(pin_hp,gpio.OUTPUT)
gpio.write(pin_hp,gpio.LOW)

pin_ir_receive = 7
gpio.mode(pin_ir_receive, gpio.INT, gpio.PULLUP)

Mark_Coeff = 0.5
-- en mS/uS
Mark_Start = 3 *Mark_Coeff *1000
Mark_Bit1 = 2 *Mark_Coeff *1000
Mark_Bit0 = 1 *Mark_Coeff *1000
Mark_Space = 0.5 *Mark_Coeff *1000

function detect_start_begin()
    t_start_begin = tmr.now()
    gpio.trig(pin_ir_receive,"up",detect_start_end)
end

function detect_start_end()
    t_start_len = tmr.now()-t_start_begin
    if t_start_len >= Mark_Start*0.8 and t_start_len <= Mark_Start*1.2 then
        ir_code =  0   num_bit = 0
        print("stxfir")
        gpio.trig(pin_ir_receive,"down",detect_bit_begin)
    else
        gpio.trig(pin_ir_receive,"none")
    end
end

function detect_bit_begin()
    t_bit_begin = tmr.now()
    gpio.trig(pin_ir_receive,"up",detect_bit_end)
end

function detect_bitt_end()
    bit_ok = flase
    t_bit_len = tmr.now()-t_bit_begin
    if t_bit_len >= Mark_Bit1*0.8 and t_bit_len <= Mark_Bit1*1.2 then
        ir_code = ir_code+(1+num_bit)^2
        bit_ok = true
    elseif t_bit_len >= Mark_Bit0*0.8 and t_bit_len <= Mark_Bit0*1.2 then
        bit_ok = true
    end
    if bit_ok = true then
        if num_bit <= 3 then
            num_bit = num_bit+1
            gpio.trig(pin_ir_receive,"down",detect_bit_begin)
        else
            print("code reçu: "..ir_code)
            gpio.trig(pin_ir_receive,"down",detect_start_begin)
        end
    else
        ir_code = 200
        gpio.trig(pin_ir_receive,"none")
        print("code error")
    end
end

gpio.trig(pin_ir_receive,"down",detect_start_begin)



--[[
i=1  j=i

function pulse_detected()
--    gpio.write(pin_hp,gpio.HIGH)
    --tmr.delay(500)
    i=i+1
--    gpio.write(pin_hp,gpio.LOW)
end


ir_receive_tmr1=tmr.create()
tmr.alarm(ir_receive_tmr1, 500, tmr.ALARM_AUTO, function()
    if i~=j then
        gpio.write(pin_hp,gpio.HIGH)
        print(i)
        j=i
        gpio.write(pin_hp,gpio.LOW)
    end
end)
]]


