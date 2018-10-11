-- Programme qui allume la led bleue quand on appuie le bouton flash
-- zf181011.1749

print("\n btn_led_front.lua zf181011.1819 \n")


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
        print(zled_state)
end

gpio.trig(zswitch, "both", zbtn)
