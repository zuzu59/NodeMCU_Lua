--Programme pour augmenter l'intensité d'une led au même temps que l'autre led descend d'intensité
--hv20180712.1503

zledred=1
zledgreen=2
zlum=1023
zinc=-1023/40
zduration = 80

function zincrementation()
    zlum=zlum+zinc
    if (zlum<0) or (zlum>1023) then
        zinc=zinc*-1
        zlum=zlum+2*zinc
    end
    pwm.setduty(zledred, zlum)
    pwm.setduty(zledgreen, 1023-zlum)
    print(zlum..","..zinc)
end

pwm.start(zledred)
pwm.setup(zledred,100,zlum)
pwm.start(zledgreen)
pwm.setup(zledgreen,100,1023-zlum)
zalarm1 = tmr.create()
tmr.alarm(zalarm1, zduration, tmr.ALARM_AUTO, zincrementation)

