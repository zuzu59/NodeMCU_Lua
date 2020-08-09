-- parse les données GPX avec les données des ap wifi du NodeMCU pour les 
-- cooréler  en fonction du temps afin de pouvoir géolocaliser les ap wifi 

print("\n gpx2gpsapwifi.lua   zfzf200809.1646   \n")

zgpx_tab = {}
zidx_gpx_tab = 0

zap_wifi_tab = {}
zidx_ap_wifi_tab1 = 0
zidx_ap_wifi_tab2 = 0

zap_wifi_unique_tab = {}
zidx_ap_wifi_unique_tab = 0

zpet_tracker_tab = {}
zidx_pet_tracker_tab1 = 0
zidx_pet_tracker_tab2 = 0

zvote_tab = {}
zidx_vote_tab = 0

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

function ap_wifi2tab(zfile_ap_wifi)
    i = 1
    for line in io.lines(zfile_ap_wifi) do
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
        zap_wifiname = string.sub(line, p2+3, p3-2)
        -- print(zap_wifi)
        -- on récupère le RSSI
        p4 = string.len(line)
        zrssi = string.sub(line, p3+2, p4)
        -- print(zrssi)
        -- est-ce un nouveau groupe de time ?
        if zunixtime ~= ztime_old then
            ztime_old = zunixtime
            zidx_ap_wifi_tab2 = 0
            zidx_ap_wifi_tab1 = zidx_ap_wifi_tab1 + 1
            zap_wifi_tab[zidx_ap_wifi_tab1] = {unixtime = zunixtime, time = zunixtime2datetime(zunixtime), lon = 0, lat = 0, {}}
        end
        zidx_ap_wifi_tab2 = zidx_ap_wifi_tab2 + 1
        zap_wifi_tab[zidx_ap_wifi_tab1][zidx_ap_wifi_tab2] = {mac = zmacadresse, name = zap_wifiname, rssi = zrssi, error = math.floor(zround(zcalc_distance(zrssi),0))}
        -- juste un petit verrou pour ne pas parser tout le fichiers pendant les tests
        i = i + 1
        if i > 20000 then break end
    end    
end

function gpx2gpsap_wifi()
    for i=1, #zap_wifi_tab do
        -- print("groupe: "..i)
        -- print("time ap_wifi: "..zap_wifi_tab[i].time)
        -- print("unxitime ap_wifi: "..zap_wifi_tab[i].unixtime)
        -- print("lon: "..zap_wifi_tab[i].lon)
        -- print("lat: "..zap_wifi_tab[i].lat)
        j = 1
        while zgpx_tab[j].unixtime < zap_wifi_tab[i].unixtime do
            -- print("coucou")
            j = j + 1
        end
        -- print("j: "..j)
        -- print("time gpx: "..zgpx_tab[j].time)
        -- print("unxitime gpx: "..zgpx_tab[j].unixtime)
        zap_wifi_tab[i].lon = zgpx_tab[j].lon
        zap_wifi_tab[i].lat = zgpx_tab[j].lat
        -- print("lon: "..zap_wifi_tab[i].lon)
        -- print("lat: "..zap_wifi_tab[i].lat)
    end    
end

function zprint_ap_wifi_tab(ztab)
    for i=1, #ztab do
        print("groupe: "..i.." -----------------")
        print("time: "..ztab[i].time)
        print("unxitime: "..ztab[i].unixtime)
        print("lon: "..ztab[i].lon)
        print("lat: "..ztab[i].lat)
        print("nombre de paternes: "..#ztab[i].."x")
        for j=1 , #ztab[i] do
            print("idx: "..j)
            print("mac: "..ztab[i][j].mac)
            print("name: "..ztab[i][j].name)
            print("rssi: "..ztab[i][j].rssi)
            print("error: "..ztab[i][j].error)
        end
    end
end


gpx2tab("osman_2020-07-27_22-03_Mon.gpx")
ap_wifi2tab("pet_tracker_200727.2203.csv")
gpx2gpsap_wifi()
-- zprint_ap_wifi_tab()


function zfind_unique_ap_wifi()
    zidx_ap_wifi_unique_tab = 0
    for i=1, #zap_wifi_tab do
        -- print("groupe: "..i.." -----------------")
        -- print("time: "..zap_wifi_tab[i].time)
        -- print("unxitime: "..zap_wifi_tab[i].unixtime)
        -- print("lon: "..zap_wifi_tab[i].lon)
        -- print("lat: "..zap_wifi_tab[i].lat)
        for j=1 , #zap_wifi_tab[i] do
            -- print("idx: "..j)
            -- print("mac: "..zap_wifi_tab[i][j].mac)
            -- print("name: "..zap_wifi_tab[i][j].name)
            -- print("rssi: "..zap_wifi_tab[i][j].rssi)
            -- print("error: "..zap_wifi_tab[i][j].error)
            zmacadresse = zap_wifi_tab[i][j].mac
            if zap_wifi_unique_tab[zmacadresse] == nil then
                -- print("oh un nouveau: "..zap_wifi_tab[i][j].mac..zap_wifi_tab[i][j].name)
                zap_wifi_unique_tab[zmacadresse] = {
                    name = zap_wifi_tab[i][j].name, 
                    error = zap_wifi_tab[i][j].error, 
                    nb = 1, 
                    lon = zap_wifi_tab[i].lon, 
                    lat = zap_wifi_tab[i].lat}
                -- zap_wifi_unique_tab[zmacadresse] = {lon = zap_wifi_tab[i][j].lon, lat =zap_wifi_tab[i][j].lat}
                zidx_ap_wifi_unique_tab = zidx_ap_wifi_unique_tab + 1
            else
                if zap_wifi_tab[i][j].error < zap_wifi_unique_tab[zmacadresse].error then
                    -- print("oh il est plus proche "..zap_wifi_tab[i][j].error.." < "..zap_wifi_unique_tab[zmacadresse].error)
                    zap_wifi_unique_tab[zmacadresse].error = zap_wifi_tab[i][j].error
                    zap_wifi_unique_tab[zmacadresse].nb = zap_wifi_unique_tab[zmacadresse].nb + 1
                    zap_wifi_unique_tab[zmacadresse].lon = zap_wifi_tab[i].lon
                    zap_wifi_unique_tab[zmacadresse].lat = zap_wifi_tab[i].lat
                end
            end
        end
    end
end

function zprint_ap_wifi_unique()
    print("mac, name, nb, lon, lat, error")
    for key,value in pairs(zap_wifi_unique_tab) do
        print(
            key..", \""..
            zap_wifi_unique_tab[key].name.."\", "..
            zap_wifi_unique_tab[key].nb..", "..
            zap_wifi_unique_tab[key].lon..", "..
            zap_wifi_unique_tab[key].lat..", "..
            zap_wifi_unique_tab[key].error)
    end    
end


zfind_unique_ap_wifi()
-- zprint_ap_wifi_unique()
-- print("j'en ai trouvé "..zidx_ap_wifi_unique_tab.."x")


-- affiche toutes les données pour un seul ap wifi afin de déterminer sa localisation visuellement
function zget_ap_wifi(zmacadresse)
    print('"mac", "name", "lon", "lat", "error"')
    zidx_get_ap_wiifi = 0
    for i=1, #zap_wifi_tab do
        print("groupe: "..i.." -----------------")
        -- print("time: "..zap_wifi_tab[i].time)
        -- print("unxitime: "..zap_wifi_tab[i].unixtime)
        -- print("lon: "..zap_wifi_tab[i].lon)
        -- print("lat: "..zap_wifi_tab[i].lat)
        for j=1 , #zap_wifi_tab[i] do
            print("idx: "..j)
            -- print("mac: "..zap_wifi_tab[i][j].mac)
            -- print("name: "..zap_wifi_tab[i][j].name)
            -- print("rssi: "..zap_wifi_tab[i][j].rssi)
            -- print("error: "..zap_wifi_tab[i][j].error)
            if zap_wifi_tab[i][j].mac == zmacadresse then
                zidx_get_ap_wiifi = zidx_get_ap_wiifi + 1
                print(
                    zap_wifi_tab[i][j].mac..", \""..
                    zap_wifi_tab[i][j].name.."\", "..
                    zap_wifi_tab[i].lon..", "..
                    zap_wifi_tab[i].lat..", "..
                    zap_wifi_tab[i][j].error)
            end
        end
    end
    print("J'en ai trouvé "..zidx_get_ap_wiifi.."x")
end


-- zget_ap_wifi("7a:d3:8d:fc:e9:a9")



function pet_tracker2tab(zfile_pettracker)
    i = 1
    for line in io.lines(zfile_pettracker) do
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
        zap_wifiname = string.sub(line, p2+3, p3-2)
        -- print(zap_wifi)
        -- on récupère le RSSI
        p4 = string.len(line)
        zrssi = string.sub(line, p3+2, p4)
        -- print(zrssi)
        -- est-ce un nouveau groupe de time ?
        if zunixtime ~= ztime_old then
            ztime_old = zunixtime
            zidx_pet_tracker_tab2 = 0
            zidx_pet_tracker_tab1 = zidx_pet_tracker_tab1 + 1
            zpet_tracker_tab[zidx_pet_tracker_tab1] = {unixtime = zunixtime, time = zunixtime2datetime(zunixtime), lon = 0, lat = 0, {}}
        end
        zidx_pet_tracker_tab2 = zidx_pet_tracker_tab2 + 1
        zpet_tracker_tab[zidx_pet_tracker_tab1][zidx_pet_tracker_tab2] = {mac = zmacadresse, name = zap_wifiname, rssi = zrssi, error = math.floor(zround(zcalc_distance(zrssi),0))}
        -- juste un petit verrou pour ne pas parser tout le fichiers pendant les tests
        i = i + 1
        -- if i > 20 then break end
        if i > 20000 then break end
    end    
end


pet_tracker2tab("pet_tracker_200727.2203.csv")
-- zprint_ap_wifi_tab(zpet_tracker_tab)


-- fait des votations de corespondances de paternes ap wifi
-- ce qui permet de pouvoir comparer des paternes avec la déviation entre les paternes (rssi)
function zvotation_ap_wifi(zidx_pet_tracker_tab1)
    print("groupe: "..zidx_pet_tracker_tab1.." -------------------------------")
    for zidx_pet_tracker_tab2 = 1, #zpet_tracker_tab[zidx_pet_tracker_tab1] do
        print("idx: "..zidx_pet_tracker_tab2)
        zmacadresse1 = zpet_tracker_tab[zidx_pet_tracker_tab1][zidx_pet_tracker_tab2].mac
        print("zmacadresse: "..zmacadresse1)
        -- parse toute la table ap_wifi à la recherche de la mac adresse
        i = 1
        for zidx_ap_wifi_tab1 = 1, #zap_wifi_tab do
            -- print("groupe: "..zidx_ap_wifi_tab1.." -----------------")
            -- print("time: "..zap_wifi_tab[zidx_ap_wifi_tab1].time)
            -- print("unxitime: "..zap_wifi_tab[zidx_ap_wifi_tab1].unixtime)
            -- print("lon: "..zap_wifi_tab[zidx_ap_wifi_tab1].lon)
            -- print("lat: "..zap_wifi_tab[zidx_ap_wifi_tab1].lat)
            for zidx_ap_wifi_tab2 = 1 , #zap_wifi_tab[zidx_ap_wifi_tab1] do
                -- print("idx: "..zidx_ap_wifi_tab2)
                -- print("mac: "..zap_wifi_tab[zidx_ap_wifi_tab1][zidx_ap_wifi_tab2].mac)
                -- print("name: "..zap_wifi_tab[zidx_ap_wifi_tab1][zidx_ap_wifi_tab2].name)
                -- print("rssi: "..zap_wifi_tab[zidx_ap_wifi_tab1][zidx_ap_wifi_tab2].rssi)
                -- print("error: "..zap_wifi_tab[zidx_ap_wifi_tab1][zidx_ap_wifi_tab2].error)
                zmacadresse2 = zap_wifi_tab[zidx_ap_wifi_tab1][zidx_ap_wifi_tab2].mac
                -- avons-nous trouvé une corespondance ?
                if zmacadresse1 == zmacadresse2 then
                    -- print("idx: "..zidx_ap_wifi_tab2.."/"..#zap_wifi_tab[zidx_ap_wifi_tab1])
                    -- print("mac1: "..zmacadresse1)
                    -- print("mac2: "..zmacadresse2)
                    -- print("J'en ai trouvée une...")
                    -- oui ! Alors on va voter pour elle
                    zvote_tab[zidx_ap_wifi_tab1].idx = zidx_ap_wifi_tab1
                    zvote_tab[zidx_ap_wifi_tab1].vote = zvote_tab[zidx_ap_wifi_tab1].vote + 1            
                    zerror1 = zpet_tracker_tab[zidx_pet_tracker_tab1][zidx_pet_tracker_tab2].error
                    zerror2 = zap_wifi_tab[zidx_ap_wifi_tab1][zidx_ap_wifi_tab2].error
                    if zerror1 < zerror2 then
                        zdeviation = zerror1 / zerror2 
                    else
                        zdeviation = zerror2 / zerror1 
                    end
                    zvote_tab[zidx_ap_wifi_tab1].sum_deviation = zvote_tab[zidx_ap_wifi_tab1].sum_deviation + zdeviation
                    -- print("vote: "..zvote_tab[zidx_ap_wifi_tab2].vote)
                    -- print("deviation: "..zdeviation)
                end
            end
            -- juste un petit verrou pour ne pas parser tout le fichiers pendant les tests
            i = i + 1
            -- if i > 5 then break end
            if i > 50000 then break end
        end
    end
end

-- initialise le tableau de votes des paternes
function zclear_vote_tab()
    for zidx_vote_tab = 1, #zap_wifi_tab do
        zvote_tab[zidx_vote_tab] = {
            idx = 0, 
            vote = 0, 
            sum_deviation = 0,
            deviation = 0,
            key_sort = ""}
    end
    zidx_vote_tab = 0
end

-- imprime le tableau de votes des paternes
function zprint_vote_tab()
    for zidx_vote_tab = 1, #zvote_tab do
        if zvote_tab[zidx_vote_tab].idx > 0 then
            print("pour "..zvote_tab[zidx_vote_tab].idx..
            " nombre de votes "..zvote_tab[zidx_vote_tab].vote..
            ", déviation : "..zvote_tab[zidx_vote_tab].deviation)
        end
    end
end

-- calcul les déviations  et la key_sort dans le tableau de votes des paternes
function zcalc_deviations()
    for zidx_vote_tab = 1, #zvote_tab do
        if zvote_tab[zidx_vote_tab].vote > 0 then
            zvote_tab[zidx_vote_tab].deviation = zround(zvote_tab[zidx_vote_tab].sum_deviation / zvote_tab[zidx_vote_tab].vote, 2)
        end
        zvote_tab[zidx_vote_tab].key_sort = string.format("%02d",zvote_tab[zidx_vote_tab].vote)..","..string.format("%.2f",zvote_tab[zidx_vote_tab].deviation)
        -- print("key sort: "..zvote_tab[zidx_vote_tab].key_sort)
    end
end

-- tri le tableau de votes des paternes pour trouver le gagnant
function zsort_vote_tab()
    table.sort(zvote_tab, function(lhs, rhs) return lhs.key_sort > rhs.key_sort end)
end


zclear_vote_tab()
zvotation_ap_wifi(200)
zcalc_deviations()
-- zprint_vote_tab()
print("il y a "..#zpet_tracker_tab.." paternes !")
zsort_vote_tab()
print("#####################################################")
zprint_vote_tab()
print("et la gagnante est "..zvote_tab[1].idx)

