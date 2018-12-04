-- Scripts juste pour tester l'effet train
-- tout sur la couleur: https://www.w3schools.com/colors/default.asp
-- roue des couleurs: https://iro.js.org/?ref=oldsite

print("\n a_chapeau_z.lua zf181204.2057 \n")

znbled=36

function RGB_clear()
    ws2812.init()
    buffer = ws2812.newBuffer(znbled, 3)
    buffer:fill(0, 0, 0)
    ws2812.write(buffer)
end

RGB_clear()


fadeLevel=3

train1_R=255
train1_G=0
train1_B=0

train2_R=255
train2_G=0
train2_B=0

-- Buffer Train 1
myLedStrip1 = ws2812.newBuffer(znbled, 3) 
myLedStrip1:fill(0,0,0)
myLedStrip1:set(1, train1_G, train1_R, train1_B)
myLedStrip1:fade(fadeLevel)
myLedStrip1:set(2, train1_G, train1_R, train1_B)
myLedStrip1:fade(fadeLevel)
myLedStrip1:set(3, train1_G, train1_R, train1_B)
myLedStrip1:fade(fadeLevel)
myLedStrip1:set(4, train1_G, train1_R, train1_B)
ws2812.write(myLedStrip1)

-- Buffer Train 2
myLedStrip2 = ws2812.newBuffer(znbled, 3) 
myLedStrip2:fill(0,0,0)
myLedStrip2:set(znbled, train2_G, train2_R, train2_B)
myLedStrip2:fade(fadeLevel)
myLedStrip2:set(znbled-1, train2_G, train2_R, train2_B)
myLedStrip2:fade(fadeLevel)
myLedStrip2:set(znbled-2, train2_G, train2_R, train2_B)
myLedStrip2:fade(fadeLevel)
myLedStrip2:set(znbled-3, train2_G, train2_R, train2_B)
ws2812.write(myLedStrip2)

-- Buffer Train Total
myLedStrip = ws2812.newBuffer(znbled, 3)
myLedStrip:mix(255, myLedStrip1, 255, myLedStrip2)
ws2812.write(myLedStrip)

-- Train move
zspeed=25
train2timer1=tmr.create()
tmr.alarm(train2timer1, zspeed,  tmr.ALARM_AUTO, function()

  myLedStrip1:shift(1, ws2812.SHIFT_CIRCULAR)    -- direction →
  myLedStrip2:shift(-1, ws2812.SHIFT_CIRCULAR)   -- direction ←

  myLedStrip:mix(255, myLedStrip1, 255, myLedStrip2)  -- mix both train
  ws2812.write(myLedStrip)

end)
