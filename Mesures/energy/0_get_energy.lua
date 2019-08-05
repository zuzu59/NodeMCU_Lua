-- Lit le capteur LDR pour mesurer la consommation électrique du compteur de la maison
print("\n 0_get_energy.lua zf190805.1038 \n")

-- lecture: https://thingspeak.com/channels/802784/private_show

local ldr_pin = 2           -- pin de la LDR
local zledbleue=0           --led bleue 

gpio.mode(ldr_pin, gpio.INT, gpio.FLOAT)

zt1_energy = tmr.now()
zt2_energy = tmr.now()

function get_energy()
    if gpio.read(ldr_pin)==0  then
        zled_state="OFF"
        gpio.write(zledbleue, gpio.HIGH)
        zt1_energy = tmr.now()
    else 
        zled_state="ON"
        gpio.write(zledbleue, gpio.LOW)
        zt2_energy = tmr.now()
        zt_energy = (zt2_energy-zt1_energy)/1000000
        print("Durée ".. zt_energy)
        zpuissance = math.floor(3600/zt_energy)/1000
        print("Puissance ".. zpuissance.."kW")
    end
    print("btn_led: "..zled_state)
--    disp_send()
end

gpio.trig(ldr_pin, "both", get_energy)

--[[

get_energy()

]]


