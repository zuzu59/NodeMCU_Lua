-- Scripts pour régler l'horloge quand on est connecté en WIFI

print("\n set_time.lua   zf200720.2055   \n")

function set_time()
    sntp.sync(nil, nil, nil, 1)
end

function ztime()
    tm = rtctime.epoch2cal(rtctime.get()+3600)
    print(string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"], tm["day"], tm["hour"], tm["min"], tm["sec"]))
end

set_time()

