-- Clignoter les leds. Vieille méthode. Pas le faire
-- zf180709.2200

zpin1=1--led rouge 
zpin2=2--led verte 
gpio.mode(zpin1, gpio.OUTPUT)
gpio.mode(zpin2,gpio.OUTPUT)


for i=1,10 do
    print("Hello World "..i)
    gpio.write(zpin1, gpio.LOW)
    gpio.write(zpin2, gpio.HIGH)
    tmr.delay(300000)
    gpio.write(zpin1, gpio.HIGH)
    gpio.write(zpin2, gpio.LOW)
    tmr.delay(300000)
end
gpio.write(zpin2, gpio.HIGH)
