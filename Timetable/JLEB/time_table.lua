-- Rafraichissement du diff time et du web_cli
print("\n time_table.lua   aj190408.1924   \n")

function get_timetable()
--    http.get("http://192.168.4.1/?line1="..zlength.."m", nil, function(code, data)
    print("get_timetable: ")
    http.get("http://transport.opendata.ch/v1/connections?from=Cheseaux&to=Lausanne-Flon&fields[]=connections/from/departure", nil, function(code, data)
        if (code < 0) then
            print("HTTP request failed")
        else
            print(code, data)
            jp= 50   h1=string.sub (data,jp,jp+7)
            jp= 100   h2=string.sub (data,jp,jp+7)
            jp= 150   h3=string.sub (data,jp,jp+7)
            jp= 200   h4=string.sub (data,jp,jp+7)
            print(h1,h2,h3,h4)
            refresh_display()
        end
    end)
end

function refresh_display()
    print("coucou 1")    
    --            tm = rtctime.epoch2cal(rtctime.get() + 3600)      -- heure d'été
    tm = rtctime.epoch2cal(rtctime.get() + 7200)           -- heure d'hiver
    
    h0 = string.format("%02d:%02d:%02d", tm["hour"], tm["min"], tm["sec"])
    print("Il est "..h0)
    print("h2, h3",h2,h3)
    d1=zround((diff_time(h2, h0)/180),0)
    d2=zround((diff_time(h3, h0)/180),0)
    print(d1,d2)
    xfois1 = d2   xfois2 =d1
    if d1==0 then
    print("coucou 2")    
        get_timetable()
    print("coucou 3")    
--        refresh_display()
    print("coucou 4")    
    end
end


function start_refresh_display()
    tm = rtctime.epoch2cal(rtctime.get() + 7200)
    h0 = string.format("%02d:%02d:%02d", tm["hour"], tm["min"], tm["sec"])
    print("Il est "..h0)
    tm = time2sec(h0)
    print("tm: ",tm)
    if tm >= 71000 then
        ztmr_start_refresh_display:unregister()
        get_timetable()
--        refresh_display()
    end
    
end



zTm_start_refresh_display = 1*1000
ztmr_start_refresh_display = tmr.create()
tmr.alarm(ztmr_start_refresh_display, zTm_start_refresh_display, tmr.ALARM_AUTO, start_refresh_display)


zTm_refresh_display = 10*1000
ztmr_refresh_display = tmr.create()


--get_timetable()
--refresh_display()

--tmr.alarm(ztmr_refresh_display, zTm_refresh_display, tmr.ALARM_AUTO, refresh_display)

--[[
get_timetable()
refresh_display()

]]


