-- Programme qui allume la led bleue quand on appuie le bouton flash

print("\n btn_led.lua   zf200717.1659   \n")

zLED=4  gpio.write(zLED, gpio.HIGH)  gpio.mode(zLED,gpio.OUTPUT)
zswitch=3           --switch flash

gpio.mode(zswitch, gpio.INT, gpio.PULLUP)

function zbtn()
    if gpio.read(zswitch) == 0  then
        zled_state = "ON"
        gpio.write(zLED, gpio.LOW)
    else 
        zled_state="OFF"
        gpio.write(zLED, gpio.HIGH)
    end
    print("btn_led: "..zled_state)
    if disp_send ~= nil then disp_send() end
end

gpio.trig(zswitch, "both", zbtn)
