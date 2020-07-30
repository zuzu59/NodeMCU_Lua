-- parse les données GPX avec les données des ap wifi du NodeMCU pour les 
-- cooréler  en fonction du temps afin de pouvoir géolocaliser les ap wifi 

print("\n gpx2gpsapwifi.lua   zfzf200730.1715   \n")


--[[
1
    time = 123
    lon = 234
    lat = 345
2
    time = 456
    lon = 567
    lat = 678
]]


function tprint(t)    
   for key,value in pairs(t) do
       print(key, value)
   end
end

gpx_data = {} 

gpx_data[1] = {time = 123, lon = 234, lat = 345}
gpx_data[2] = {time = 456, lon = 567, lat = 678}

print(gpx_data[1].time)
print(gpx_data[1].lon)
print(gpx_data[2].lat)

tprint(gpx_data[1])

for i=1, #gpx_data do
    print(i)
    tprint(gpx_data[i])
end



function zprintline()
    print(string.sub(zline,1,string.len(zline)-1))
    zline = file.readline()
    if zline == nil then
        ztmr_cat1:unregister()
        file.close(zfilei)
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
        print(line)

        -- <trkpt lat="46.5421696" lon="6.5749532">
        if string.find(line, "<trkpt ") then
            print("coucou gps")
            -- récupère la longitude
            p1, p2 = string.find(line, "lat=\"")
            -- print(p1,p2)
            p3 = string.find(line, "\"", p2+1)
            -- print(p3)
            zlat = string.sub(line,p2+1,p3-1)
            print("lat: " ..zlat)
            -- récupère la latitude
            p1, p2 = string.find(line, "lon=\"")
            -- print(p1,p2)
            p3 = string.find(line, "\"", p2+1)
            -- print(p3)
            zlon = string.sub(line,p2+1,p3-1)
            print("lon: " ..zlon)
        end
        
        -- <time>2020-07-27T20:03:27Z</time>
        if string.find(line, "<time>") then
            print("coucou time")
            -- récupère le temps
            p1, p2 = string.find(line, "<time>")
            -- print(p1,p2)
            p3 = string.find(line, "Z</time>", p2+1)
            -- print(p3)
            ztime = string.sub(line,p2+1,p3-1)
            print("time: " ..ztime)
            zunixtime = zdatetime2unixtime(ztime)
            print("unixtime: " ..zunixtime)
            
            
            
        end
        

        i = i + 1
        if i > 20 then break end
    end
    
    
end

gpx2tab("osman_2020-07-27_22-03_Mon.gpx")
-- print(zdatetime2unixtime("2020-07-27T20:03:27"))
