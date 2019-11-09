-- fonction dir() pour afficher les fichiers dans la flash
print("\n dir.lua   zf191109.1719   \n")

hash=nil
function zhash(zstring)
    local zhash_v = 0
    for i = 1, string.len(zstring) do
        zhash_v = zhash_v + string.byte(zstring, i) * i
    end
    return zhash_v
end
status, err = pcall(function () print(zhash("il était une fois trois petits cochons roses...")) end)  if status==false then print("Error: ",err) end



function dir()
    print("\n-------------------------------")
    l=file.list() i=0
    for k,v in pairs(l) do
        i=i+v
        print(k..string.rep(" ",24-string.len(k)).." : "..v.." bytes")
    end
    print("-------------------------------")
    print('\nUsed: '..i..' bytes\nusage: dofile("file.lua")\n')
end
status, err = pcall(function () dir() end)  if status==false then print("Error: ",err) end

dir()
