-- Programme qui allume la led bleue quand on appuie le bouton flash
-- hv180711.1125

zledbleue=0 --led bleue 
zswitch=3--switch flash

gpio.mode(zswitch, gpio.INT, gpio.PULLUP)

function bouton()
    if gpio.read(zswitch)==0  then
        zstate="OFF"
        disp_send()
        --gpio.write(zledbleue, gpio.LOW)
    else 
        zstate="ON"
        disp_send()
        --gpio.write(zledbleue, gpio.HIGH)
    end
end

gpio.trig(zswitch, "both", bouton)
