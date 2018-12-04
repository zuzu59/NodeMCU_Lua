-- Scripts juste pour éteindre toutes les LED du ruban
-- tout sur la couleur: https://www.w3schools.com/colors/default.asp
-- roue des couleurs: https://iro.js.org/?ref=oldsite

print("\n az_init_led.lua zf181201.1751 \n")

znbled=300

function RGB_clear()
    ws2812.init()
    buffer = ws2812.newBuffer(znbled, 3)
    buffer:fill(0, 0, 0)
    ws2812.write(buffer)
end

print("Initializing LED strip...")
RGB_clear()
print("done.")

