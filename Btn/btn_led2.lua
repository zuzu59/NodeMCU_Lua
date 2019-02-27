-- Programme qui allume ou étiend (flip-flop) la led bleue quand on appuie le bouton flash

print("btn_led2.lua     aj190226.1649")

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
