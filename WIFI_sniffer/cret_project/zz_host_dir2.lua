#!/usr/local/bin/lua5.1
-- script lua à faire tourner sur le host pour calculer les checksum de tous les fichiers
-- du dossier en cours, donc PAS sur le NodeMCU !
-- source: https://stackoverflow.com/questions/5303174/how-to-get-list-of-directories-in-lua (30%)

print("\n zz_host_dir2.lua   zf191123.1318   \n")

function calc_chksum_file(name_file)
    size_file = 1   chksum_file = 0   local f = io.open(name_file, "r")
    while true do
        local t = f:read(1)   if t == nil then break end
        chksum_file = chksum_file + size_file * string.byte(t)
        size_file = size_file + 1
    end
    f:close()
end

function scandir(directory)
    local zdir={}   local pfile = io.popen("ls -1r "..directory)
    for name_file in pfile:lines() do
        calc_chksum_file(name_file)
        if (size_file ~= 1) and (chksum_file ~= 1) then
            zdir[#zdir+1]=name_file..string.rep(" ",24-string.len(name_file)).." : "..size_file..", "..chksum_file
        end
    end
    pfile:close()
    table.sort(zdir)
    for i=1, #zdir do
        print(zdir[i])
    end
end

scandir("./")
