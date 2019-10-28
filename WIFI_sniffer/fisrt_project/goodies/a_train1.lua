-- Scripts juste pour tester l'effet train
-- tout sur la couleur: https://www.w3schools.com/colors/default.asp
-- roue des couleurs: https://iro.js.org/?ref=oldsite

print("\n a_train1.lua zf181204.2004 \n")

znbled=36

function RGB_clear()
    ws2812.init()
    buffer = ws2812.newBuffer(znbled, 3)
    buffer:fill(0, 0, 0)
    ws2812.write(buffer)
end

RGB_clear()

j=1
local i, buffer = 0, ws2812.newBuffer(znbled, 3); buffer:fill(0, 0, 0); tmr.create():alarm(20, 1, function()
  i = i + j
  buffer:fade(2)
  buffer:set(i % buffer:size() + 1, 255, 255, 255)
  ws2812.write(buffer)
  if i>=buffer:size()-1 or i<=0 then
    j=j*-1
  end
end)


