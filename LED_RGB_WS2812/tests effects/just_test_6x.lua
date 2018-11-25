-- Scripts juste pour tester 6x LED RGB
-- tout sur la couleur: https://www.w3schools.com/colors/default.asp
-- roue des couleurs: https://iro.js.org/?ref=oldsite

print("\n just_test_3x.lua zf181106.1458 \n")


print("Initializing LED strip...")
ws2812.init()
ws2812_effects.stop()
strip_buffer = ws2812.newBuffer(6, 3)
ws2812.write(string.char(255, 0, 0,   0, 255, 0,   0, 0, 255))  -- RGB positionnement naturel

ws2812.write(string.char(0, 255, 0,   0, 0, 255,   255, 0, 0,  255, 0, 255,   255, 255, 0,   0, 255, 255))  -- GBR and CMY en GBR WS2813!

ws2812.write(string.char(0, 255, 0,   0, 0, 255/3,   255, 0, 0,  255, 0, 255,   255, 255, 0,   0, 255, 255))  -- vert compensé GBR and CMY en GBR WS2813!

ws2812.write(string.char(128, 255, 128,   200, 200, 255,    255, 200, 200,   255, 255, 255,   40, 40, 40,   5, 5, 5))  -- White RGB & White 100/50/10%

ws2812.write(string.char(0, 0, 0,   0, 0, 0,   0, 0, 0,   0, 0, 0,   0, 0, 0,   0, 0, 0))  -- LED OFF

