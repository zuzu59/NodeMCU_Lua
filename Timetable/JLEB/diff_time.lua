-- Scripts pour calculer une différence entre deux heures

print("\n diff_time.lua zf190227.1842 \n")

function time2sec(jtime)
    jsecondes = 3600 * tonumber(string.sub(jtime,1,2))
    jsecondes = jsecondes + 60 * tonumber(string.sub(jtime,4,5))
    jsecondes = jsecondes + tonumber(string.sub(jtime,7,8))
    return jsecondes
end

function diff_time(jtime1, jtime2)
    diff_secondes = time2sec(jtime1) - time2sec(jtime2)
    return diff_secondes
end

function zround(num, dec)
    local mult = 10^(dec or 0)
    return math.floor(num * mult + 0.5) / mult
end

--[[
print(diff_time("18:42:00", "18:40:00"))
]]