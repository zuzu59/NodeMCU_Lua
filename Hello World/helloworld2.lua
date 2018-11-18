-- blink the blue led builting
-- zf180709.2200

-- ATTENTION, c'est exactement ce qu'il ne faut pas faire en NodeMCU Lua, car cela bloque le NodeMCU pendant plus de 300mS !
-- Il FAUT travailler en mode événement avec un timer !


zpin=0  --led blue builting
gpio.mode(zpin, gpio.OUTPUT)

for i=1,20 do
    print("Hello World "..i)
    gpio.write(zpin, gpio.LOW)
    tmr.delay(100000)
    gpio.write(zpin, gpio.HIGH)
    tmr.delay(100000)
end
