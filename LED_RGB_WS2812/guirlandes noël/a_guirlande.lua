-- Scripts effet guirlande de Noël pour le balcon
-- tout sur la couleur: https://www.w3schools.com/colors/default.asp
-- roue des couleurs: https://iro.js.org/?ref=oldsite

print("\n a_guirlande.lua zf181216.0020 \n")

znbleds_max=300
znbleds=300
zstep=1
zpower=1

function RGB_clear()
    ws2812.init()
    buffer = ws2812.newBuffer(znbleds_max, 3)
    buffer_reg = ws2812.newBuffer(znbleds_max, 3)
    buffer:fill(0, 0, 0)
    ws2812.write(buffer)
end

function zfaderando()
    for i=1, znbleds, zstep do
        r, g, b=buffer:get(i)
        r=r+zledinc[i]   g=g+zledinc[i]   b=b+zledinc[i]
        if r >255 then
            r=255   g=255   b=255
            zledinc[i]=zrando()
        end
        if r <0 then
            r=0   g=0   b=0
            zledinc[i]=zrando()
        end
        buffer:set(i, r, g, b)
    end
end

function zrando()
    a=10
    zr=math.random(a)+5
    if math.random()<0.5 then
        zr=zr*-1
    end
--    print(zr)
    return zr
end

function zincfill()
    zledinc={}
    for i=1, znbleds, zstep do
        zledinc[i]=zrando()
    end
end

function zeffect_stop()
    tmr.unregister(effect_tmr1)
    RGB_clear()
end

function zeffect_start()
    effect_tmr1=tmr.create()
    tmr.alarm(effect_tmr1, 200,  tmr.ALARM_AUTO, function()
        zfaderando()
        zpower_reg()
        ws2812.write(buffer_reg)
    end)
end


function zpower_reg()
    psu_current_ma = 1000
    led_current_ma = 35
    led_sum_current_ma = (znbleds/zstep) * led_current_ma
--    print(znbleds, zstep, led_sum_current_ma)
    
    led_sum = (znbleds/zstep) * 255 * 3
--    print(led_sum)

    led_sum=led_sum*psu_current_ma/led_sum_current_ma
--    print(led_sum)
    
    p = buffer:power()
--    print(p,led_sum)
    if p > led_sum then
        buffer_reg:mix(256 * led_sum / p, buffer) -- power is now limited
    else
        buffer_reg:mix(255, buffer)
    end
end


RGB_clear()
zincfill()
zeffect_start()



