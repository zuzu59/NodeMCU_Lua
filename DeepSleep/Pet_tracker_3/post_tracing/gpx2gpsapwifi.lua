-- parse les données GPX avec les données des ap wifi du NodeMCU pour les 
-- cooréler  en fonction du temps afin de pouvoir géolocaliser les ap wifi 

print("\n gpx2gpsapwifi.lua   zfzf200804.1048   \n")

zgpx_tab = {}
zidx_gpx_tab = 0

zapwifi_tab = {}
zidx_apwifi_tab1 = 0
zidx_apwifi_tab2 = 0

zapwifi_unique_tab = {}
zidx_apwifi_unique_tab = 0

ztime_old = 0
ztime2020 = 1577836800      -- Unix time pour 1.1.2020 0:0:0 GMT
ztimezone = 2*3600


function zround(num, dec)
    local mult = 10^(dec or 0)
    return math.floor(num * mult + 0.5) / mult
end

function zcalc_distance(zrssi)
    zrssi_1m=-40    zn=2
    zdist=10^((zrssi_1m - zrssi) / (10 * zn))
    return zdist
end

function tprint(t)    
   for key,value in pairs(t) do
       print(key, value)
   end
end

function zunixtime2datetime(zunixtime)
    local datetime = os.date("%Y/%m/%d %H:%M:%S",zunixtime-ztimezone)
    return datetime
end

function zdatetime2unixtime(zdatetime)
    -- source: https://stackoverflow.com/questions/4105012/convert-a-string-date-to-a-timestamp
    -- https://www.unixtimestamp.com/index.php
    -- Assuming a date pattern like: yyyy-mm-ddThh:mm:ss
    local pattern = "(%d+)-(%d+)-(%d+)T(%d+):(%d+):(%d+)"
    -- local timeToConvert = "2020-07-27T20:03:27"
    local timeToConvert = zdatetime
    local runyear, runmonth, runday, runhour, runminute, runseconds = timeToConvert:match(pattern)
    local convertedTimestamp = os.time({year = runyear, month = runmonth, day = runday, hour = runhour, min = runminute, sec = runseconds})
    return (convertedTimestamp+ztimezone)
end

function gpx2tab(zfile_gpx)    
    i = 1
    for line in io.lines(zfile_gpx) do
        -- print(line)
        -- <trkpt lat="46.5421696" lon="6.5749532">
        if string.find(line, "<trkpt ") then
            -- print("coucou gps")
            -- récupère la longitude
            p1, p2 = string.find(line, "lat=\"")
            -- print(p1,p2)
            p3 = string.find(line, "\"", p2+1)
            -- print(p3)
            zlat = string.sub(line,p2+1,p3-1)
            -- print("lat: " ..zlat)
            -- récupère la latitude
            p1, p2 = string.find(line, "lon=\"")
            -- print(p1,p2)
            p3 = string.find(line, "\"", p2+1)
            -- print(p3)
            zlon = string.sub(line,p2+1,p3-1)
            -- print("lon: " ..zlon)
        end
        -- <time>2020-07-27T20:03:27Z</time>
        if string.find(line, "<time>") then
            -- print("coucou time")
            -- récupère le temps
            p1, p2 = string.find(line, "<time>")
            -- print(p1,p2)
            p3 = string.find(line, "Z</time>", p2+1)
            -- print(p3)
            ztime = string.sub(line,p2+1,p3-1)
            -- print("time: " ..ztime)
            zunixtime = zdatetime2unixtime(ztime)+ztimezone
            -- print("unixtime: " ..zunixtime)
            -- on a le temps et les coordonnées on peut les sauver dans le tableau§
            zidx_gpx_tab = zidx_gpx_tab + 1
            zgpx_tab[zidx_gpx_tab] = {unixtime = zunixtime, time = zunixtime2datetime(zunixtime),lon = zlon, lat = zlat}
        end
        -- juste un petit verrou pour ne pas parser tout le fichiers pendant les tests
        i = i + 1
        if i > 20000 then break end
    end
end

function apwifi2tab(zfile_apwifi)
    i = 1
    for line in io.lines(zfile_apwifi) do
        -- print(line)
        -- 18050624, b0:7f:b9:3e:f1:f1, "apzuzu6_EXT", -71
        -- on récupère le temps unix 2020
        p1 = string.find(line, ",")
        zunixtime2020 = string.sub(line, 1, p1-1)
        -- print(zunixtime2020)
        -- on récupère le temps unix 1970
        zunixtime = zunixtime2020 + ztime2020
        -- print(zunixtime)
        -- on récupère la mac adresse
        p2 = string.find(line, ",", p1+1)
        zmacadresse = string.sub(line, p1+2, p2-1)
        -- print(zmacadresse)
        -- on récupère le nom de l'ap wifi
        p3 = string.find(line, ",", p2+1)
        zapwifiname = string.sub(line, p2+3, p3-2)
        -- print(zapwifi)
        -- on récupère le RSSI
        p4 = string.len(line)
        zrssi = string.sub(line, p3+2, p4)
        -- print(zrssi)
        -- est-ce un nouveau groupe de time ?
        if zunixtime ~= ztime_old then
            ztime_old = zunixtime
            zidx_apwifi_tab2 = 0
            zidx_apwifi_tab1 = zidx_apwifi_tab1 + 1
            zapwifi_tab[zidx_apwifi_tab1] = {unixtime = zunixtime, time = zunixtime2datetime(zunixtime), lon = 0, lat = 0, {}}
        end
        zidx_apwifi_tab2 = zidx_apwifi_tab2 + 1
        zapwifi_tab[zidx_apwifi_tab1][zidx_apwifi_tab2] = {mac = zmacadresse, name = zapwifiname, rssi = zrssi, error = math.floor(zround(zcalc_distance(zrssi),0))}
        -- juste un petit verrou pour ne pas parser tout le fichiers pendant les tests
        i = i + 1
        if i > 20000 then break end
    end    
end

function gpx2gpsapwifi()
    for i=1, #zapwifi_tab do
        -- print("groupe: "..i)
        -- print("time apwifi: "..zapwifi_tab[i].time)
        -- print("unxitime apwifi: "..zapwifi_tab[i].unixtime)
        -- print("lon: "..zapwifi_tab[i].lon)
        -- print("lat: "..zapwifi_tab[i].lat)
        j = 1
        while zgpx_tab[j].unixtime < zapwifi_tab[i].unixtime do
            -- print("coucou")
            j = j + 1
        end
        -- print("j: "..j)
        -- print("time gpx: "..zgpx_tab[j].time)
        -- print("unxitime gpx: "..zgpx_tab[j].unixtime)
        zapwifi_tab[i].lon = zgpx_tab[j].lon
        zapwifi_tab[i].lat = zgpx_tab[j].lat
        -- print("lon: "..zapwifi_tab[i].lon)
        -- print("lat: "..zapwifi_tab[i].lat)
    end    
end

function zprint_apwifi_tab()
    for i=1, #zapwifi_tab do
        print("groupe: "..i.." -----------------")
        print("time: "..zapwifi_tab[i].time)
        print("unxitime: "..zapwifi_tab[i].unixtime)
        print("lon: "..zapwifi_tab[i].lon)
        print("lat: "..zapwifi_tab[i].lat)
        for j=1 , #zapwifi_tab[i] do
            print("idx: "..j)
            print("mac: "..zapwifi_tab[i][j].mac)
            print("name: "..zapwifi_tab[i][j].name)
            print("rssi: "..zapwifi_tab[i][j].rssi)
            print("error: "..zapwifi_tab[i][j].error)
        end
    end
end


gpx2tab("osman_2020-07-27_22-03_Mon.gpx")
apwifi2tab("pet_tracker_200727.2203.csv")
gpx2gpsapwifi()
-- zprint_apwifi_tab()


function zfind_unique_ap_wifi()
    zidx_apwifi_unique_tab = 0
    for i=1, #zapwifi_tab do
        -- print("groupe: "..i.." -----------------")
        -- print("time: "..zapwifi_tab[i].time)
        -- print("unxitime: "..zapwifi_tab[i].unixtime)
        -- print("lon: "..zapwifi_tab[i].lon)
        -- print("lat: "..zapwifi_tab[i].lat)
        for j=1 , #zapwifi_tab[i] do
            -- print("idx: "..j)
            -- print("mac: "..zapwifi_tab[i][j].mac)
            -- print("name: "..zapwifi_tab[i][j].name)
            -- print("rssi: "..zapwifi_tab[i][j].rssi)
            -- print("error: "..zapwifi_tab[i][j].error)
            zmacadresse = zapwifi_tab[i][j].mac
            if zapwifi_unique_tab[zmacadresse] == nil then
                -- print("oh un nouveau: "..zapwifi_tab[i][j].mac..zapwifi_tab[i][j].name)
                zapwifi_unique_tab[zmacadresse] = {
                    name = zapwifi_tab[i][j].name, 
                    error = zapwifi_tab[i][j].error, 
                    nb = 1, 
                    lon = zapwifi_tab[i].lon, 
                    lat = zapwifi_tab[i].lat}
                -- zapwifi_unique_tab[zmacadresse] = {lon = zapwifi_tab[i][j].lon, lat =zapwifi_tab[i][j].lat}
                zidx_apwifi_unique_tab = zidx_apwifi_unique_tab + 1
            else
                if zapwifi_tab[i][j].error < zapwifi_unique_tab[zmacadresse].error then
                    -- print("oh il est plus proche "..zapwifi_tab[i][j].error.." < "..zapwifi_unique_tab[zmacadresse].error)
                    zapwifi_unique_tab[zmacadresse].error = zapwifi_tab[i][j].error
                    zapwifi_unique_tab[zmacadresse].nb = zapwifi_unique_tab[zmacadresse].nb + 1
                    zapwifi_unique_tab[zmacadresse].lon = zapwifi_tab[i].lon
                    zapwifi_unique_tab[zmacadresse].lat = zapwifi_tab[i].lat
                end
            end
        end
    end
end

function zprint_ap_wifi_unique()
    print("mac, name, nb, lon, lat, error")
    for key,value in pairs(zapwifi_unique_tab) do
        print(
            key..", \""..
            zapwifi_unique_tab[key].name.."\", "..
            zapwifi_unique_tab[key].nb..", "..
            zapwifi_unique_tab[key].lon..", "..
            zapwifi_unique_tab[key].lat..", "..
            zapwifi_unique_tab[key].error)
    end    
end


zfind_unique_ap_wifi()
-- zprint_ap_wifi_unique()
-- print("j'en ai trouvé "..zidx_apwifi_unique_tab.."x")

-- affiche toutes les données pour un seul ap wifi afin de déterminer sa localisation visuelle
function zget_ap_wifi(zmacadresse)
    print('"mac", "name", "lon", "lat", "error"')
    zidx_get_ap_wiifi = 0
    for i=1, #zapwifi_tab do
        print("groupe: "..i.." -----------------")
        -- print("time: "..zapwifi_tab[i].time)
        -- print("unxitime: "..zapwifi_tab[i].unixtime)
        -- print("lon: "..zapwifi_tab[i].lon)
        -- print("lat: "..zapwifi_tab[i].lat)
        for j=1 , #zapwifi_tab[i] do
            print("idx: "..j)
            -- print("mac: "..zapwifi_tab[i][j].mac)
            -- print("name: "..zapwifi_tab[i][j].name)
            -- print("rssi: "..zapwifi_tab[i][j].rssi)
            -- print("error: "..zapwifi_tab[i][j].error)
            if zapwifi_tab[i][j].mac == zmacadresse then
                zidx_get_ap_wiifi = zidx_get_ap_wiifi + 1
                print(
                    zapwifi_tab[i][j].mac..", \""..
                    zapwifi_tab[i][j].name.."\", "..
                    zapwifi_tab[i].lon..", "..
                    zapwifi_tab[i].lat..", "..
                    zapwifi_tab[i][j].error)
            end
        end
    end
    print("J'en ai trouvé "..zidx_get_ap_wiifi.."x")
end


zget_ap_wifi("7a:d3:8d:fc:e9:a9")






--[[
zgpx_tab
1
    time = 123
    lon = 234
    lat = 345
2
    time = 456
    lon = 567
    lat = 678

gpx_data[1] = {time = 123, lon = 234, lat = 345}
]]

--[[
zapwifi_tab
-- 18050624, b0:7f:b9:3e:f1:f1, "apzuzu6_EXT", -71
1
    unixtime
    time
    lon
    lat
    apwifi 
        mac
        name
        rssi
        error
        
        
2
    ...
            
zapwifi_tab[1] = {time = 123, lon = 234, lat = 345, {}}
zapwifi_tab[1][1] = {mac = 456, rssi = 567}
zapwifi_tab[1][2] = {mac = 678, rssi = 789}

print(zapwifi_tab[1][1].rssi)
print(zapwifi_tab[1][2].mac)

]]





-- print(zdatetime2unixtime("2020-07-27T20:03:27"))

-- for i=1, #zgpx_tab do
--     print(i)
--     tprint(zgpx_tab[i])
-- end

-- zapwifi_tab[zidx_apwifi_tab1] = {unixtime = zunixtime, time = os.date("%Y/%m/%d %H:%M:%S",zunixtime-ztimezone), lon = 0, lat = 0, {}}
-- zapwifi_tab[zidx_apwifi_tab1][zidx_apwifi_tab2] = {mac = zmacadresse, name = zapwifiname, rssi = zrssi, error = 1234}
