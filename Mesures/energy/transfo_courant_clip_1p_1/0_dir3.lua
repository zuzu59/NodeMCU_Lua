-- fonction dir_vers() pour afficher toutes les versions de tous les fichiers *.lua sur le NodeMCU !
-- fonction filec(fichier) pour afficher la version d'un seul fichiers sur le NodeMCU !

print("\n 0_dir3.lua   zf200611.1519   \n")

-- function calc_chksum_file()
--     local name_file = list_files[zcmpt1]
--     print(name_file)
--     local size_file = 1   local chksum_file = 0
--     local f = file.open(name_file, "r")
--     while true do
--         local t = f:read(1)   if t == nil then break end
--         chksum_file = chksum_file + size_file * string.byte(t)
--         size_file = size_file + 1
--         if size_file%100 == 0 then uart.write(0,".") end
--     end
--     f:close()   print("")
--     zdir[#zdir+1]=name_file..string.rep(" ",24-string.len(name_file)).." : "..size_file..", "..chksum_file
--     zcmpt1 = zcmpt1 + 1
--     zrepeat()
-- end

function file_vers(name_file)
    print(name_file)
    zdir[#zdir+1]=name_file
end
     
    
    
    
    
--     print(name_file)
--     local f = file.open(name_file, "r")
--     while true do
--         local t = f:readline()   if t == nil then break end
--         print("/"..t.."/")
--         -- recherche de l'entête de version [print("\n ]
--         -- astuce, il faut échapper la ( avec un % et convertir le \ en char(92)
--         k='print%("'..string.char(92).."n "
--         i,j = string.find(t,k)
--         print(i,j)
-- 
--         if i ~= nil then
--             print(t)
--             break
--         end
--         uart.write(0,".")
--     end
--     f:close()   print("")
--     -- print(name_file..string.rep(" ",24-string.len(name_file)).." : "..size_file..", "..chksum_file)
-- end

--[[
file_vers("dir.lua")
file_vers("dir3.lua")
file_vers("cat.lua")
]]

function zrepeat()
    if zcmpt1 <= #list_files then
        -- node.task.post(calc_chksum_file)
        --node.task.post(file_vers(list_files[zcmpt1]))
        file_vers(list_files[zcmpt1])
        
    else
        table.sort(zdir)   for i=1, #zdir do   print(zdir[i])   end
        zdir=nil   list_files=nil   zcmpt1=nil
    end
end

function dir_vers()
    zdir={}   list_files={}
    local pfile = file.list()
    for k,v in pairs(pfile) do
        file_vers(k)
        -- list_files[#list_files+1]=k
    end
    -- zcmpt1 = 1   zrepeat()
end

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
file_vers("dir.lua")
file_vers("dir3.lua")
file_vers("cat.lua")

dir()
dir_vers()


=node.heap()
clear_dir()
=node.heap()

for k,v in pairs(_G) do print(k,v) end

status, err = pcall(function () print(zhash("il était une fois trois petits cochons roses...")) end)  if status==false then print("Error: ",err) end
]]
