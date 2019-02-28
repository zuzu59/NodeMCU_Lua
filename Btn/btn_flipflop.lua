-- Petit scripts pour faire un flip flop avec le bouton et la led du nodemcu
-- Très intéressant la techno utilisée ici pour enlever les rebonds du micro switch
-- dans la variable b se trouve l'heure à laquelle l'interruption est arrivée, il suffit juste alors de lui mettre un petit délai de 300mS

print("\n btn_flipflop.lua zf190228.0935 \n")

gpio.write(0,1)
gpio.mode(0,gpio.OUTPUT)
gpio.mode(3,gpio.INT)

d=tmr.now()

function zled (a,b,c)
    print("a: "..a..",b: "..b..",c: "..c)
    if b-d > 300*1000 then
        if gpio.read(0) == 0 then
            gpio.write(0,1)
        else
            gpio.write(0,0)
        end
        print(gpio.read(0))
        d=b
    end
end

gpio.trig(3, "down", zled)

print("tutu")
