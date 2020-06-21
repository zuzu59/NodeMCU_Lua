-- Petit scripts pour faire un flip flop avec le bouton et la led du nodemcu
-- Très intéressant la techno utilisée ici pour enlever les rebonds du micro switch
-- dans la variable b se trouve l'heure à laquelle l'interruption est arrivée, 
-- il suffit juste alors de lui mettre un petit délai de 300mS

print("\n 0_btn_flipflop.lua   zf200621.1942   \n")

gpio.write(zLED,1)  gpio.mode(zLED,gpio.OUTPUT)
gpio.mode(zBTN,gpio.INT)

btn_time=tmr.now()

function z_btn_led (a,b,c)
    --print("a: "..a..",b: "..b..",c: "..c)
    if b-btn_time > 300*1000 then
        if verbose then
            gpio.write(zLED, gpio.LOW)   tmr.delay(10000)   gpio.write(zLED, gpio.HIGH) 
            verbose=false
        else
            gpio.write(zLED, gpio.LOW)   tmr.delay(200000)   gpio.write(zLED, gpio.HIGH)
            verbose=true
        end
        btn_time=b
        print("verbose:",verbose)
    end
end

gpio.trig(zBTN, "down", z_btn_led)
