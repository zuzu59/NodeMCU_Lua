-- parse les données GPX avec les données des ap wifi du NodeMCU pour les 
-- cooréler  en fonction du temps afin de pouvoir géolocaliser les ap wifi 

print("\n gpx2gpsapwifi.lua   zfzf200731.1842   \n")


zgpx_tab = {}
zidx_gpx_tab = 0

zapwifi_tab = {}
zidx_apwifi_tab1 = 0
zidx_apwifi_tab2 = 0

ztime_old = 0
ztime2020 = 1577836800      -- Unix time pour 1.1.2020 0:0:0 GMT


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
        erreur
        
        
2
    ...
            
zapwifi_tab[1] = {time = 123, lon = 234, lat = 345, {}}
zapwifi_tab[1][1] = {mac = 456, rssi = 567}
zapwifi_tab[1][2] = {mac = 678, rssi = 789}

print(zapwifi_tab[1][1].rssi)
print(zapwifi_tab[1][2].mac)

]]






function tprint(t)    
   for key,value in pairs(t) do
       print(key, value)
   end
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
    return (convertedTimestamp+2*3600)
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
            zunixtime = zdatetime2unixtime(ztime)
            -- print("unixtime: " ..zunixtime)
            -- on a le temps et les coordonnées on peut les sauver dans le tableau§
            zidx_gpx_tab = zidx_gpx_tab + 1
            zgpx_tab[zidx_gpx_tab] = {unixtime = zunixtime, time = ztime,lon = zlon, lat = zlat}
        end
        -- juste un petit verrou pour ne pas parser tout le fichiers pendant les tests
        i = i + 1
        if i > 20000 then break end
    end
end



function apwifi2tab(zfile_apwifi)
    i = 1
    
    for line in io.lines(zfile_apwifi) do
        print(line)

        -- 18050624, b0:7f:b9:3e:f1:f1, "apzuzu6_EXT", -71
        -- on récupère le temps unix 2020
        p1 = string.find(line, ",")
        zunixtime2020 = string.sub(line, 1, p1-1)
        print(zunixtime2020)
        -- on récupère le temps unix 1970
        zunixtime = zunixtime2020 + ztime2020
        print(zunixtime)
        -- on récupère la mac adresse
        p2 = string.find(line, ",", p1+1)
        zmacadresse = string.sub(line, p1+2, p2-1)
        print(zmacadresse)
        -- on récupère le nom de l'ap wifi
        p3 = string.find(line, ",", p2+1)
        zapwifiname = string.sub(line, p2+3, p3-2)
        print(zapwifi)
        -- on récupère le RSSI
        p4 = string.len(line)
        zrssi = string.sub(line, p3+2, p4)
        print(zrssi)
        
        -- est-ce un nouveau groupe de time ?
        if zunixtime ~= ztime_old then
            ztime_old = zunixtime
            zidx_apwifi_tab2 = 0
            zidx_apwifi_tab1 = zidx_apwifi_tab1 + 1
            zapwifi_tab[zidx_apwifi_tab1] = {unixtime = zunixtime, time = os.date("%Y/%m/%d %H:%M:%S",zunixtime-2*3600), lon = 0, lat = 0, {}}
        end

        zidx_apwifi_tab2 = zidx_apwifi_tab2 + 1
        zapwifi_tab[zidx_apwifi_tab1][zidx_apwifi_tab2] = {mac = zmacadresse, name = zapwifiname, rssi = zrssi, erreur = 1234}

        -- juste un petit verrou pour ne pas parser tout le fichiers pendant les tests
        i = i + 1
        if i > 20 then break end
    end
    
    
end


-- print(zdatetime2unixtime("2020-07-27T20:03:27"))

-- gpx2tab("osman_2020-07-27_22-03_Mon.gpx")
-- 
-- 
-- for i=1, #zgpx_tab do
--     print(i)
--     tprint(zgpx_tab[i])
-- end

apwifi2tab("pet_tracker_200727.2203.csv")


-- zapwifi_tab[zidx_apwifi_tab1] = {unixtime = zunixtime, time = os.date("%Y/%m/%d %H:%M:%S",zunixtime-2*3600), lon = 0, lat = 0, {}}
-- zapwifi_tab[zidx_apwifi_tab1][zidx_apwifi_tab2] = {mac = zmacadresse, name = zapwifiname, rssi = zrssi, erreur = 1234}


for i=1, #zapwifi_tab do
    print(i)
    print("time: "..zapwifi_tab[i].time)
    print("unxitime: "..zapwifi_tab[i].unixtime)
    print("lon: "..zapwifi_tab[i].lon)
    print("lat: "..zapwifi_tab[i].lat)
    for j=1 , #zapwifi_tab[i] do
        print(j)
        print("mac: "..zapwifi_tab[i][j].mac)
        print("name: "..zapwifi_tab[i][j].name)
        print("rssi: "..zapwifi_tab[i][j].rssi)
        print("erreur: "..zapwifi_tab[i][j].erreur)
    end
end




