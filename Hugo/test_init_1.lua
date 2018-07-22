--Programme qui démarre le robot en appuyant sur le bouton flash et le redémarre si le bouton flash est appuyer pendant 3 secondes
--hv20180716.1349

zBTNflash = 3 -- GPIO0 button
function btn_clic()
    t1=tmr.now()
    tmr.alarm(0,100,tmr.ALARM_AUTO, btn_test)
end
function btn_test()
    t2=tmr.now()
    t3=(t2-t1)/1000000
    print("t3: "..t3)
    if gpio.read(zBTNflash)==1 then
        tmr.stop(0)
        gpio.trig(zBTNflash)
        dofile("robot_1.lua")
    end
    if t3>2 then
        tmr.stop(0)
        gpio.trig(zBTNflash)
        node.restart()
    end
end
gpio.mode(zBTNflash,gpio.INT)
gpio.trig(zBTNflash, "down", btn_clic)

