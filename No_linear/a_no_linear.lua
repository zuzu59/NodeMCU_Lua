-- Script pour corriger une mesure d'un capteur non linéaire
-- ici on simule une lecture d'un device branché sur 
-- l'entrée du convertisseur analogique A0

print("\n a_no_linear.lua zf19042227 \n")

zcourbe_correction="t1.csv"

function get_correction(zx)
    if file.open(zcourbe_correction, "r") then
        local line = string.gsub(file.read('\n'),"\n","")
        line = string.gsub(file.read('\n'),"\n","")
        zx2, zy2 = zsplit(line)
        repeat
            zx1 = zx2   zy1 = zy2
            line = string.gsub(file.read('\n'),"\n","")
            zx2, zy2 = zsplit(line)
        until zx < zx2
            print(zx1,zx2)
            print(zy1,zy2)
        file.close()
    end
end

function zsplit(zline)
    local zx, zy = zline:match("([^,]+),([^,]+)")
    print("-"..zx.."-"..zy.."-")
    return tonumber(zx), tonumber(zy)
end



get_correction(100)


--[[
f= "a_no_linear.lua"   if file.exists(f) then dofile(f) end   zget_meteo()

get_correction(100)

-- On affiche combien on a de RAM
print(node.heap())

]]
