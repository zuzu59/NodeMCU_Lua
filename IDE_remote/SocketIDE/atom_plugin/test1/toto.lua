print("c'est toto")

--l = file.list();for k,v in pairs(l) do print('name:'..k..', size:'..v)end

function dir2()
    l = file.list();for k,v in pairs(l) do print('name:'..k..', size:'..v)end
end



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

--[[
dir()
dir2()

]]