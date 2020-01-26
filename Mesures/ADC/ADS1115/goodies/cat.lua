-- fonction cat() pour afficher le contenu d'un fichier dans la flash
print("\n cat.lua   zf191124.2204   \n")

function zread_line()
    local zline = ""
    while true do
        local t = zf:read(1)   if t == nil then return end
        zline = zline..t
        if t == "\n" then   return string.sub(zline,1,string.len(zline)-1)   end
    end
end

function cat(zfile)
    print("\n"..zfile.."\n-------------------------------")
    zf = file.open(zfile, "r")
    while true do
        zline = zread_line()   if zline == nil then break end
        print(zline)
    end
    zf:close()
    print("-------------------------------")
end
