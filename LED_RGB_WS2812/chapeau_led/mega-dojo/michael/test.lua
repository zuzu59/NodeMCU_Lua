-- Scripts juste pour tester l'effet train
-- tout sur la couleur: https://www.w3schools.com/colors/default.asp
-- roue des couleurs: https://iro.js.org/?ref=oldsite

print("\n test.lua zf181207.1634 \n")

nbleds=36
fade1=0.05   fade2=0.2   fade3=0.4   fade4=1
R1=255   G1=0   B1=0
R2=0   G2=0   B2=255
train_speed=50
ws2812.init()
myLedStrip = ws2812.newBuffer(nbleds, 3)
myLedStrip1 = ws2812.newBuffer(nbleds, 3) 
myLedStrip2 = ws2812.newBuffer(nbleds, 3) 

function RGB_clear()
    myLedStrip:fill(0, 0, 0)   ws2812.write(myLedStrip)
end

function train1_fill()
    myLedStrip1:fill(0,0,0)
    myLedStrip1:set(1, G1*fade1, R1*fade1, B1*fade1)
    myLedStrip1:set(2, G1*fade2, R1*fade2, B1*fade2)
    myLedStrip1:set(3, G1*fade3, R1*fade3, B1*fade3)
    myLedStrip1:set(4, G1*fade4, R1*fade4, B1*fade4)
end

function train2_fill()
    myLedStrip2:fill(0,0,0)
    myLedStrip2:set(nbleds, G2*fade1, R2*fade1, B2*fade1)
    myLedStrip2:set(nbleds-1, G2*fade2, R2*fade2, B2*fade2)
    myLedStrip2:set(nbleds-2, G2*fade3, R2*fade3, B2*fade3)
    myLedStrip2:set(nbleds-3, G2*fade4, R2*fade4, B2*fade4)
end

function train_mix()
    myLedStrip:mix(255, myLedStrip1, 255, myLedStrip2)
end

function train_shift()
    myLedStrip1:shift(1, ws2812.SHIFT_CIRCULAR)
    myLedStrip2:shift(-1, ws2812.SHIFT_CIRCULAR)
end

function train_write()
    ws2812.write(myLedStrip)
end

function train_start()
    train3timer1=tmr.create()
    tmr.alarm(train3timer1, train_speed,  tmr.ALARM_AUTO, function()
        train_shift()
        train_mix()
        train_write()
    end)
end

function train_stop()
    tmr.unregister(train3timer1)
    RGB_clear()
end

RGB_clear()
train1_fill()
train2_fill()
train_start()
