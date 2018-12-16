-- Scripts effet guirlande de Noël pour le balcon
-- tout sur la couleur: https://www.w3schools.com/colors/default.asp
-- roue des couleurs: https://iro.js.org/?ref=oldsite

print("\n a_guirlande.lua zf181216.0131 \n")

znbleds_max=300
znbleds=300
zstep=5
zpower=1

zleds={}
zledinc={}

function RGB_clear()
    ws2812.init()
    buffer = ws2812.newBuffer(znbleds_max, 3)
    buffer:fill(0, 0, 0)
    ws2812.write(buffer)
end

function zleds_init()
    for i=1, znbleds, zstep do
        zleds[i]=0
    end
end

function zfaderando()
    for i=1, znbleds, zstep do
        zleds[i]=zleds[i]+zledinc[i]
        if zleds[i] >255 then
            zleds[i]=255
            zledinc[i]=zrando()
        end
        if zleds[i] <0 then
            zleds[i]=0
            zledinc[i]=zrando()
        end
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
    for i=1, znbleds, zstep do
        zledinc[i]=zrando()
    end
end

function zbufferfill()
    for i=1, znbleds, zstep do
        buffer:set(i, zleds[i], zleds[i], zleds[i])
    end
end

function zeffect_stop()
    tmr.unregister(effect_tmr1)
    RGB_clear()
end

function zeffect_start()
    effect_tmr1=tmr.create()
    tmr.alarm(effect_tmr1, 300,  tmr.ALARM_AUTO, function()
        zfaderando()
        zbufferfill()
        zpower_reg()
        ws2812.write(buffer)
    end)
end

function zfade(f)
    for i=1, znbleds, zstep do
        r, g, b=buffer:get(i)
        buffer:set(i, r*f, g*f, b*f)
    end
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
    if p > led_sum then
        f=led_sum/p
--        print("f: ",f)
--        print(p)
        zfade(f)
--        p = buffer:power()
--        print(p)
    end
end


RGB_clear()
zleds_init()
zincfill()
zeffect_start()



