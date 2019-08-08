-- Programme qui allume la led bleue quand on appuie le bouton flash
-- zf181011.1749

print("\n btn_led.lua zf190808.1540 \n")


zledbleue=0         --led bleue 
zswitch=3           --switch flash

gpio.mode(zswitch, gpio.INT, gpio.PULLUP)

function zbtn()
    if gpio.read(zswitch)==0  then
        zled_state="ON"
        gpio.write(zledbleue, gpio.LOW)
    else 
        zled_state="OFF"
        gpio.write(zledbleue, gpio.HIGH)
    end
    print("btn_led: "..zled_state)
--    disp_send()
end

gpio.trig(zswitch, "both", zbtn)
