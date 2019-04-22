-- Script pour corriger une mesure d'un capteur non linéaire
-- ici on simule une lecture d'un device branché sur 
-- l'entrée du convertisseur analogique A0

print("\n a_no_linear.lua zf190422.1134 \n")

zcourbe_correction="t1.csv"

function get_correction(zx0)
    file_csv = file.open(zcourbe_correction, "r")
    if file_csv then
        local line = file_csv:readline()        -- lit la première ligne header
        line = file_csv:readline()   zx2, zy2 = zsplit(line)
        repeat
            zx1 = zx2   zy1 = zy2
            line = file_csv:readline()   zx2, zy2 = zsplit(line)
        until zx0 <= zx2
        file_csv:close()  file_csv = nil
        print(zx1,zx2)   print(zy1,zy2)

        local zx = zx0 - zx1
        local zm = zx / (zx2 - zx1)
        local zy = (zy2 - zy1) * zm
        zy0 = zy1 + zy        
    end
end

function zsplit(zline)
    local zline = string.gsub(zline,"\n","")
    local zx, zy = zline:match("([^,]+),([^,]+)")
    print("-"..zx.."-"..zy.."-")
    return tonumber(zx), tonumber(zy)
end


zx0=100
get_correction(zx0)
print("la valeur corrigée de "..zx0.." est: "..zy0) 


--[[
f= "a_no_linear.lua"   if file.exists(f) then dofile(f) end   zget_meteo()

get_correction(83)
get_correction(91)
get_correction(100)


-- On affiche combien on a de RAM
print(node.heap())

]]
