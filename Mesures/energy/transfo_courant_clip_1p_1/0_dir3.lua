-- fonction dir_vers() pour afficher toutes les versions de tous les fichiers *.lua sur le NodeMCU !
-- fonction filec(fichier) pour afficher la version d'un seul fichiers sur le NodeMCU !

print("\n 0_dir3.lua   zf200611.1651   \n")

function file_vers(name_file)
    local z=""
    if string.find(name_file,"%.lua") then
        z=name_file..":"
        -- print("fichier: "..name_file)
        local f,i1,i2,j1,j2,k,t = f,i1,i2,j1,j2,k,t
        f = file.open(name_file, "r")
        while true do
            local t = f:readline()   if t == nil then break end
    --        print("/"..t.."/")
            -- recherche de l'entête de version [print("\n ]
            -- astuce, il faut échapper la ( avec un % et convertir le \ en char(92)
            k='print%("'..string.char(92).."n "
            i1,j1 = string.find(t,k)

    --        print(i,j)

            if i1 ~= nil then
                k=string.char(92)..'n"%)'
                i2,j2 = string.find(t,k,j1)
--                print(t)
--                print(i1,j1,i2,j2)
                z=name_file..": "..string.sub(t,j1+1,i2-2)
--                print(z)
                break
            end
--            uart.write(0,".")
        end
        f:close()
        print(z)        
    end
    return z
end

function dir_vers()
    zdir={}   list_files={}
    local k,v = k,v   local pfile = file.list()
    for k,v in pairs(pfile) do
        zdir[#zdir+1] = file_vers(k)
        -- print(file_vers(k))
        -- list_files[#list_files+1]=k
    end
    print("\n\nEt le résultat est.....................")
    table.sort(zdir)   for i=1, #zdir do   print(zdir[i])   end
    -- zcmpt1 = 1   zrepeat()
end

--[[
for i=1, #zdir do   print(zdir[i])   end
]]




function dir()
    local zdir={}
    local pfile = file.list()
    for k,v in pairs(pfile) do
        zdir[#zdir+1] = k..string.rep(" ",24-string.len(k)).." : "..v
    end
    table.sort(zdir)   for i=1, #zdir do   print(zdir[i])   end
    size_file=nil   chksum_file=nil  k=nil
end

function clear_dir()
    dir=nil   dir2=nil   dirc=nil filec=nil
    zrepeat=nil   calc_chksum_file=nil
end

dir()
print("\nusage:")
print("   dir()")
print("   dir_vers()")
print("   file_vers('dir2.lua')")


--[[
dir()
dir_vers()

file_vers("dir.lua")
file_vers("dir3.lua")
file_vers("cat.lua")



=node.heap()
clear_dir()
=node.heap()

for k,v in pairs(_G) do print(k,v) end

status, err = pcall(function () print(zhash("il était une fois trois petits cochons roses...")) end)  if status==false then print("Error: ",err) end
]]
