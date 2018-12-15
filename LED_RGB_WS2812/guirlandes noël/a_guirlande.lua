-- Scripts effet guirlande de Noël pour le balcon
-- tout sur la couleur: https://www.w3schools.com/colors/default.asp
-- roue des couleurs: https://iro.js.org/?ref=oldsite

print("\n a_guirlande.lua zf181215.2027 \n")

znbleds=300
zstep=5
zpower=0.5

function RGB_clear()
    ws2812.init()
    buffer = ws2812.newBuffer(znbleds, 3)
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

function zlog(l)
    a=2
    l=0.3+l^a/310^a
    return l
end

print(zlog(0))
print(zlog(128))
print(zlog(255))

function zrando()
    a=10
    zr=math.random(a)+5
    if math.random()<0.5 then
        zr=zr*-1
    end
    print(zr)
    return zr
end

function zincfill()
    zledinc={}
    for i=1, znbleds, zstep do
        zledinc[i]=zrando()
    end
end

function zledfill()
    for i=1, znbleds, zstep do
        a=30
        l=math.random(0,255/a)*a
--        l=i*(255/znbleds)  
        k=zlog(l)
--        print(i,l,l*k,k)
        l=l*k
        l=255
        buffer:set(i, l*zpower, l*zpower, l*zpower)
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
        ws2812.write(buffer)
    end)
end



RGB_clear()
zledfill()
ws2812.write(buffer)

zincfill()

zeffect_start()






