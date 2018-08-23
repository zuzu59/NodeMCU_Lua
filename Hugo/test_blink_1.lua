-- Clignoter la led bleue. Vieille méthode, pas le faire
-- zf180709.2200

zpin=0  --led blue builting
gpio.mode(zpin, gpio.OUTPUT)

for i=1,20 do
    print("Hello World "..i)
    gpio.write(zpin, gpio.LOW)
    tmr.delay(100000)
    gpio.write(zpin, gpio.HIGH)
    tmr.delay(100000)
end
