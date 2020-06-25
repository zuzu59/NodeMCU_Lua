-- Scripts pour régler l'horloge quand on est connecté en WIFI
-- Permet aussi de 'compresser' le unix time afin de prendre moins de place dans les strings
-- je suis en train de faire une version plus économique au niveau RAM (voir à la fin)
print("\n set_time2.lua zf200611.1926 \n")

--source: https://www.freeformatter.com/epoch-timestamp-to-date-converter.html

ztime2019 = 1546300800      -- Unix time pour le 1.1.2019

function set_time()
    sntp.sync(nil, nil, nil, 1)
end

function ztime_compress(ztime_long)
    return ztime_long - ztime2019
end

function ztime_uncompress(ztime_short)
    return ztime_short + ztime2019
end

function ztime_format(ztime)
    tm = rtctime.epoch2cal(ztime + 3600)
    return(string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"], tm["day"], tm["hour"], tm["min"], tm["sec"]))
end

set_time()
print(ztime_format(rtctime.get()))


-- function ztime_stamp()  return tmr.now()/1000000  end

-- sntp.sync(nil, nil, nil, 1)
-- 
-- function ztime_format(ztime)
--     tm = rtctime.epoch2cal(ztime + 3600)
--     return(string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"], tm["day"], tm["hour"], tm["min"], tm["sec"]))
-- end
-- 
-- print(ztime_format(rtctime.get()+3600))
-- 
-- zsec, zusec = rtctime.get()
-- 
-- print(zsec, zusec)
-- zsec=zsec+3600+zusec/1000000
-- print(ztime_format(zsec))
-- 
-- print(zsec)
-- znanosec= zsec*1000000000
-- print(znanosec)


