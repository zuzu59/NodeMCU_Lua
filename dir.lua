-- fonction dir() pour afficher les fichiers dans la flash
-- zf180717.1542

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
