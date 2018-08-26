-- fonction dir() pour afficher les fichiers dans la flash
print("\n dir.lua   zf180826.1019   \n")

function dir()
    print("\n-------------------------------")
    l=file.list() i=0
    for k,v in pairs(l) do
        i=i+v
        print(k..string.rep(" ",19-string.len(k)).." : "..v.." bytes")
    end
    print("-------------------------------")
    print('\nUsed: '..i..' bytes\nusage: dofile("file.lua")\n')
end

dir()
