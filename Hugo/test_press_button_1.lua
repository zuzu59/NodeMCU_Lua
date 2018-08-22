-- lit le switch flash et allume la led bleue. Veille méthode, pas le faire
-- zf180710.1606

zledbleue=0  --led blue builting
zswitch=3  --switch flash

gpio.mode(zledbleue, gpio.OUTPUT)
gpio.mode(zswitch, gpio.INPUT)

for i=1,10 do
    print("Hello World "..i)
    if gpio.read(zswitch) == 1 then
        gpio.write(zledbleue, gpio.HIGH)
    else
        gpio.write(zledbleue, gpio.LOW)
    end
    tmr.delay(1000000)
end
