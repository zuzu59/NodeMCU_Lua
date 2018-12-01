-- Scripts juste pour tester des effets à la mano
-- tout sur la couleur: https://www.w3schools.com/colors/default.asp
-- roue des couleurs: https://iro.js.org/?ref=oldsite

print("\n a_tst_fill.lua zf181125.1632 \n")

znbled=300

function RGB_clear()
    ws2812.init()
    buffer = ws2812.newBuffer(znbled, 3)
    buffer:fill(0, 0, 0)
    ws2812.write(buffer)
end

function RGB_fill(nbled, Red, Green, Blue)
    buffer = ws2812.newBuffer(nbled, 3)
    buffer:fill(Green, Red, Blue)           -- Green, Red , Blue
    ws2812.write(buffer)
end

RGB_clear()
RGB_clear() ; RGB_fill(100, 255, 0, 0)
RGB_clear() ; RGB_fill(100, 0, 255, 0)
RGB_clear() ; RGB_fill(100, 0, 0, 255)
RGB_clear() ; l=0.10 ; R=l*(255) ; G=l*(80*0.99) ; B=l*(0*0.99) ; RGB_fill(300, R, G, B)




