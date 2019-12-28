#!/usr/local/bin/lua5.1
-- script lua à faire tourner sur le host pour la taille de tous les fichiers
-- du dossier en cours, donc PAS sur le NodeMCU !
-- source: https://stackoverflow.com/questions/5303174/how-to-get-list-of-directories-in-lua (30%)

-- usage dans la console:
-- ./zz_host_dir.lua
--[[
./zz_host_dir.lua > thost
]]
-- usage dans Atom editor
-- il faut installer ceci: https://atom.io/packages/compare-files
-- puis sélectionner les deux fichiers dans l'explorateur à gauche puis CTRL+CMD+C


print("\n zz_host_dir.lua   zf191124.1646   \n")

function calc_chksum_file(name_file)
    size_file = 0   chksum_file = 0
    local f = io.open(name_file, "r")
--    local f = file.open(name_file, "r")
    while true do
        local t = f:read(1)   if t == nil then break end
--        chksum_file = chksum_file + size_file * string.byte(t)
        size_file = size_file + 1
--        if size_file%100 == 0 then uart.write(0,".") end
    end
    f:close()
--    print(name_file)
end

function dirfile(k)
    calc_chksum_file(k)
    print(k..string.rep(" ",24-string.len(k)).." : "..size_file..", "..chksum_file)
    size_file=nil   chksum_file=nil  k=nil
end

function dir()
    local zdir={}
    local pfile = io.popen("ls -1r *.lua *.html")
    for k in pfile:lines() do
--    local pfile = file.list()
--    for k,v in pairs(pfile) do
        calc_chksum_file(k)
        if (size_file ~= 1) and (chksum_file ~= 1) then
            zdir[#zdir+1]=k..string.rep(" ",24-string.len(k)).." : "..size_file
        end
    end
    pfile:close()
    table.sort(zdir)
    for i=1, #zdir do
        print(zdir[i])
    end
    size_file=nil   chksum_file=nil  k=nil
end

dir()
print("\n\nRappel, sur Atom, sélectionner les deux fichiers à gauche puis CTRL+CMD+C\n")

--[[
dir()
dirfile("dir2.lua")

for k,v in pairs(_G) do print(k,v) end

status, err = pcall(function () print(zhash("il était une fois trois petits cochons roses...")) end)  if status==false then print("Error: ",err) end
]]
