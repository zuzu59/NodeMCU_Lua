-- Scripts juste pour allumer ou éteindre une LED sur un ruban RGB
-- tout sur la couleur: https://www.w3schools.com/colors/default.asp
-- roue des couleurs: https://iro.js.org/?ref=oldsite

print("\n led_rgb.lua zf190303.1436 \n")

nbleds=3
ws2812.init()
myLedStrip = ws2812.newBuffer(nbleds, 3)

function RGB_clear()
    myLedStrip:fill(0, 0, 0)   ws2812.write(myLedStrip)
end

function RGB_reform(R1, G1, B1)         --conversion de RGB à BRG
    rR1=B1   rG1=R1   rB1=G1
end

function zled_rgb(num_led, R1, G1, B1, zpower)
    RGB_reform(R1, G1, B1)
    myLedStrip:set(num_led, rR1*zpower, rG1*zpower, rB1*zpower)
    ws2812.write(myLedStrip)
end

function zled_write()
    ws2812.write(myLedStrip)
end


RGB_clear()

--[[
zled_rgb(1,255,0,0,1)
zled_rgb(2,0,255,0,1)
zled_rgb(2,0,255,0,0.05)
zled_rgb(3,0,0,255,1)
]]
