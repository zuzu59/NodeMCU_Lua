-- Scripts pour régler l'horloge quand on est connecté en WIFI
-- et la sauve dans un fichier pour si jamais on n'a pas d'Internet
-- au power boot
-- https://www.unixtimestamp.com/index.php

print("\n set_time2.lua   zf200815.1426   \n")

function set_time()
    sntp.sync(nil, nil, nil, 1)
end

-- function ztime()
--     tm = rtctime.epoch2cal(rtctime.get()+2*3600)
--     print(string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"], tm["day"], tm["hour"], tm["min"], tm["sec"]))
-- end

function zget_time()
    zrtc_time = rtctime.get()
    if zrtc_time > 0 then
        ztmr_set_time:alarm(60*1000, tmr.ALARM_SINGLE , zget_time)
        print("j'ai trouvé l'heure: "..zrtc_time)
        file.putcontents("_ztime_", zrtc_time)
        -- print(file.getcontents("_ztime_"))
    else
        ztmr_set_time:alarm(1*1000, tmr.ALARM_SINGLE , zget_time)
        print("je cherche l'heure: "..zrtc_time)
    end

end

ztmr_set_time = tmr.create()
ztmr_set_time:alarm(1*1000, tmr.ALARM_SINGLE , zget_time)

set_time()
