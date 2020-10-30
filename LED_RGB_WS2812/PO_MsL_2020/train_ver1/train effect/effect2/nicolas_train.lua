--[[

  This file is a test for a led strip WS2813 
    Intelligent control LED integrated light source

  This use the module ws2812:
    https://nodemcu.readthedocs.io/en/master/en/modules/ws2812/

]]

-- define the led strip total length
stripLength=24


-- Test 1
-- This turn off the led strip for 1 second
ws2812.init()
myLedStrip = ws2812.newBuffer(stripLength, 3) -- 6 leds with 3 colors 
myLedStrip:fill(0,0,0)
ws2812.write(myLedStrip)
tmr.delay(1 * 1000000) -- wait for 1 s


-- Test 2
-- This is the minimal test: it will initialize and turn on the first
-- 3 leds to:
--    1. 255, 0, 0
--    2. 0, 255, 0
--    3. 0, 0, 255
-- Note: The leds strip are not necessarily in RGB, this test aim to 
--       find out what the type of led you have. In my case, it's BRG.
ws2812.init()
ws2812.write(string.char(255, 0, 0, --[[ ]] 0, 255, 0,  --[[ ]] 0, 0, 255))
tmr.delay(1 * 1000000) -- wait for 1 s
-- Now you can see that the luminosity is very different according to the main color.
-- In fact, you need to correct the luminosity for the humain eye, something as
ws2812.write(string.char(180, 0, 0, --[[ ]] 0, 255, 0,  --[[ ]] 0, 0, 60))
tmr.delay(3 * 1000000) -- wait for 3 s


-- Test 3
-- Traffic lights
ws2812.init()
ws2812.write(string.char(0, 255, 0, --[[]] 0, 0, 0,  --[[]] 0, 0, 0)) -- RED
tmr.delay(2 * 1000000) -- wait for 2 s
ws2812.write(string.char(0, 0, 0, --[[]] 0, 255, 44, --[[]] 0, 0, 0)) -- ORANGE B0 R255 G88 
tmr.delay(1 * 1000000) -- wait for 1 s
ws2812.write(string.char(0, 0, 0, --[[]] 0, 0, 0,  --[[]] 0, 0, 255)) -- GREEN
tmr.delay(3 * 1000000) -- wait for 3 s


-- Test 4
-- This show the luminosity gradient
-- The first arg: led position, then: color
myLedStrip = ws2812.newBuffer(stripLength, 3) -- 6 leds with 3 colors 
myLedStrip:fill(0,0,0)
ws2812.write(myLedStrip)
-- RED
myLedStrip:set( 1, 0, 10, 0)
myLedStrip:set( 2, 0, 20, 0)
myLedStrip:set( 3, 0, 40, 0)
myLedStrip:set( 4, 0, 80, 0)
myLedStrip:set( 5, 0, 160, 0)
myLedStrip:set( 6, 0, 255, 0)
-- GREEN
myLedStrip:set( 7, 0, 0, 10)
myLedStrip:set( 8, 0, 0, 20)
myLedStrip:set( 9, 0, 0, 40)
myLedStrip:set(10, 0, 0, 80)
myLedStrip:set(11, 0, 0, 160)
myLedStrip:set(12, 0, 0, 255)
-- BLUE 
myLedStrip:set(13, 10, 0, 0)
myLedStrip:set(14, 20, 0, 0)
myLedStrip:set(15, 40, 0, 0)
myLedStrip:set(16, 80, 0, 0)
myLedStrip:set(17, 160, 0, 0)
myLedStrip:set(18, 255, 0, 0)

ws2812.write(myLedStrip)
tmr.delay(3 * 1000000) -- wait for 3 s


-- Test 5
-- k2000 fx (Brace yourself,  David Hasselhoff!)
ws2812.init()
fadeLevel=3
timerSpeed=20 -- timer speed in milliseconds
mode = ws2812.SHIFT_CIRCULAR -- ws2812.SHIFT_LOGICAL / ws2812.SHIFT_CIRCULAR

-- Buffer Train 1
myLedStrip1 = ws2812.newBuffer(stripLength, 3) -- 6 leds with 3 colors 
myLedStrip1:fill(0,0,0)
myLedStrip1:set(1, 100,100,100)
myLedStrip1:fade(fadeLevel)
myLedStrip1:set(2, 100,100,100)
myLedStrip1:fade(fadeLevel)
myLedStrip1:set(3, 100,100,100)
myLedStrip1:fade(fadeLevel)
myLedStrip1:set(4, 100,100,100)
-- debug: ws2812.write(myLedStrip1)

-- Buffer Train 2
myLedStrip2 = ws2812.newBuffer(stripLength, 3) -- 6 leds with 3 colors 
myLedStrip2:fill(0,0,0)
myLedStrip2:set(stripLength, 0,0,120)
myLedStrip2:fade(fadeLevel)
myLedStrip2:set(stripLength-1, 0,0,120)
myLedStrip2:fade(fadeLevel)
myLedStrip2:set(stripLength-2, 0,0,120)
myLedStrip2:fade(fadeLevel)
myLedStrip2:set(stripLength-3, 0,0,120)
myLedStrip2:fade(fadeLevel)
-- debug: ws2812.write(myLedStrip2)

-- Buffer Train Total
myLedStrip = ws2812.newBuffer(stripLength, 3) -- 6 leds with 3 colors 
myLedStrip:mix(255, myLedStrip1, 255, myLedStrip2)
-- debug: ws2812.write(myLedStrip)

tmr.create():alarm(timerSpeed, 1, function()

  myLedStrip1:shift(1, mode)    -- direction →
  myLedStrip2:shift(-1, mode)   -- direction ←

  myLedStrip:mix(255, myLedStrip1, 255, myLedStrip2)  -- mix both train
  ws2812.write(myLedStrip)

end)


-- end of file