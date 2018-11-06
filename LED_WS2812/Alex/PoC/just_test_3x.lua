-- Scripts juste pour tester 3x LED RGB
-- tout sur la couleur: https://www.w3schools.com/colors/default.asp
-- roue des couleurs: https://iro.js.org/?ref=oldsite

print("\n just_test_3x.lua zf181105.1428 \n")


print("Initializing LED strip...")
ws2812.init()
ws2812_effects.stop()
strip_buffer = ws2812.newBuffer(3, 3)
ws2812.write(string.char(0, 255, 0, 255, 0, 0, 0, 0, 255))
ws2812.write(string.char(255, 0, 255, 0, 255, 255, 255, 255, 0))
ws2812.write(string.char(128, 255, 64, 255, 200, 200, 200, 200, 255))
ws2812.write(string.char(255, 255, 255, 40, 40, 40, 5, 5, 5))
ws2812.write(string.char(0, 0, 0, 0, 0, 0, 0, 0, 0))

