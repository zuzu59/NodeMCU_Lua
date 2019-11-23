-- fonction dir() pour calculer le checksum de tous les fichiers sur le NodeMCU !
-- fonction dirfile(fichier) pour calculer le checksum d'un seul fichiers sur le NodeMCU !

print("\n dir2.lua   zf191123.1410   \n")

function calc_chksum_file(name_file)
    size_file = 1   chksum_file = 0
--    local f = io.open(name_file, "r")
    local f = file.open(name_file, "r")
    while true do
        local t = f:read(1)   if t == nil then break end
        chksum_file = chksum_file + size_file * string.byte(t)
        size_file = size_file + 1
        if size_file%100 == 0 then uart.write(0,".") end
    end
    f:close()
    print(name_file)
end

function dirfile(k)
    calc_chksum_file(k)
    print(k..string.rep(" ",24-string.len(k)).." : "..size_file..", "..chksum_file)
    size_file=nil   chksum_file=nil  k=nil
end

function dir()
    local zdir={}
--    local pfile = io.popen("ls -1r ")
--    for k in pfile:lines() do
    local pfile = file.list()
    for k,v in pairs(pfile) do
        calc_chksum_file(k)
        if (size_file ~= 1) and (chksum_file ~= 1) then
            zdir[#zdir+1]=k..string.rep(" ",24-string.len(k)).." : "..size_file..", "..chksum_file
        end
    end
--    pfile:close()
    table.sort(zdir)
    for i=1, #zdir do
        print(zdir[i])
    end
    size_file=nil   chksum_file=nil  k=nil
end

--dir()

--[[
dir()
dirfile("dir2.lua")

for k,v in pairs(_G) do print(k,v) end

status, err = pcall(function () print(zhash("il était une fois trois petits cochons roses...")) end)  if status==false then print("Error: ",err) end
]]
