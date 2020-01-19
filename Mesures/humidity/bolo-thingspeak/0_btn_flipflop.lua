-- Petit scripts pour faire un flip flop avec le bouton et la led du nodemcu
-- Très intéressant la techno utilisée ici pour enlever les rebonds du micro switch
-- dans la variable b se trouve l'heure à laquelle l'interruption est arrivée, il suffit juste alors de lui mettre un petit délai de 300mS

print("\n 0_btn_flipflop.lua   zf200119.1527 \n")

gpio.write(zLED,1)
gpio.mode(zLED,gpio.OUTPUT)
gpio.mode(zBTN,gpio.INT)

d=tmr.now()

function zled (a,b,c)
    if verbose then print("a: "..a..",b: "..b..",c: "..c) end
    if b-d > 300*1000 then
        if verbose then
            gpio.write(zLED,1) verbose=false
        else
            gpio.write(zLED,0) verbose=true
        end
        if verbose then print(gpio.read(zLED)) end
        d=b
    end
end

gpio.trig(zBTN, "down", zled)
