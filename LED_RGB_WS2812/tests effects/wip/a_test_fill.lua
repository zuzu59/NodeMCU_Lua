-- Scripts juste pour tester des effets à la mano
-- tout sur la couleur: https://www.w3schools.com/colors/default.asp
-- roue des couleurs: https://iro.js.org/?ref=oldsite

print("\n a_tst_train.lua zf181125.1258 \n")

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


znbled_tst=10
zlumino=1                      --luminosité 0 <> 1
zR=255*zlumino
zG=255*zlumino
zB=255*zlumino
buffer = ws2812.newBuffer(znbled_tst, 3)
buffer:fill(0, 0, 255)           -- Green, Red , Blue
ws2812.write(buffer)



--[[

print("toto")

ws2812.init()
strip_buffer = ws2812.newBuffer(300, 3)
ws2812_effects.init(strip_buffer)
-- initially all leds off
ws2812_effects.set_speed(255)
ws2812_effects.set_brightness(0)
ws2812_effects.set_color(0,0,0)
ws2812_effects.start()
print("done.")
print()

ws2812.init()

local i, buffer = 0, ws2812.newBuffer(300, 3)
buffer:fill(0, 0, 0, 0)

exit


ws2812.init()
j=1
local i, buffer = 0, ws2812.newBuffer(300, 3); buffer:fill(0, 0, 0, 0); tmr.create():alarm(20, 1, function()
  i = i + j
  buffer:fade(2)
  buffer:set(i % buffer:size() + 1, 255, 255, 255)
  ws2812.write(buffer)
  if i>=buffer:size()-1 or i<=0 then
    j=j*-1
  end
end)




ws2812.write(string.char(255, 0, 0,   0, 255, 0,   0, 0, 255))  -- RGB positionnement naturel

ws2812.write(string.char(0, 255, 0,   0, 0, 255,   255, 0, 0,  255, 0, 255,   255, 255, 0,   0, 255, 255))  -- GBR and CMY en GBR WS2813!

ws2812.write(string.char(0, 255, 0,   0, 0, 255/3,   255, 0, 0,  255, 0, 255,   255, 255, 0,   0, 255, 255))  -- vert compensé GBR and CMY en GBR WS2813!

ws2812.write(string.char(128, 255, 128,   200, 200, 255,    255, 200, 200,   255, 255, 255,   40, 40, 40,   5, 5, 5))  -- White RGB & White 100/50/10%

ws2812.write(string.char(0, 0, 0,   0, 0, 0,   0, 0, 0,   0, 0, 0,   0, 0, 0,   0, 0, 0))  -- LED OFF
]]
