-- Lit le capteur LDR pour mesurer la consommation électrique du compteur de la maison
print("\n 0_get_energy.lua zf190803.2138 \n")

-- lecture: https://thingspeak.com/channels/802784/private_show

local ldr_pin = 2           -- pin de la LDR
local zledbleue=0           --led bleue 

gpio.mode(ldr_pin, gpio.INT, gpio.FLOAT)

function get_energy()
    if gpio.read(ldr_pin)==0  then
        zled_state="OFF"
        gpio.write(zledbleue, gpio.HIGH)
    else 
        zled_state="ON"
        gpio.write(zledbleue, gpio.LOW)
    end
    print("btn_led: "..zled_state)
--    disp_send()
end

gpio.trig(ldr_pin, "both", get_energy)

--[[

get_energy()

]]

