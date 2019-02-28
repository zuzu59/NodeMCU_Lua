-- Scripts juste pour allumer ou éteindre une LED sur un ruban RGB
-- tout sur la couleur: https://www.w3schools.com/colors/default.asp
-- roue des couleurs: https://iro.js.org/?ref=oldsite

print("\n jled_rgb.lua jv190227.1626 \n")

nbleds=6
ws2812.init()
myLedStrip = ws2812.newBuffer(nbleds, 3)

function RGB_clear()
    myLedStrip:fill(0, 0, 0)   ws2812.write(myLedStrip)
end

function RGB_reform(R1, G1, B1)         --RGB to GRB
    rR1=G1   rG1=R1   rB1=B1
end

function jled_rgb(num_led, R1, G1, B1, jpower)
    RGB_reform(R1, G1, B1)
    myLedStrip:set(num_led, rR1*jpower, rG1*jpower, rB1*jpower)
    ws2812.write(myLedStrip)
end

function jled_write()
    ws2812.write(myLedStrip)
end


RGB_clear()

--[[
jled_rgb(1,255,0,0,1)
jled_rgb(4,0,0,255,1)
jled_rgb(4,0,0,255,0.05)
jled_rgb(6,0,255,0,1)

]]
