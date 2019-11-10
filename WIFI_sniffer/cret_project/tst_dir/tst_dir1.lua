#!/usr/local/bin/lua5.1
-- fonction dir() pour afficher les fichiers dans le dossier sur le host, donc PAS sur le NodeMCU !
-- source: https://stackoverflow.com/questions/5303174/how-to-get-list-of-directories-in-lua (30%)

print("\n tst_dir1.lua   zf191110.1959   \n")

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
    local pfile = io.popen("ls -1 "..directory)
    for name_file in pfile:lines() do
        calc_chksum_file(name_file)
        print(name_file..string.rep(" ",24-string.len(name_file)).." : "..size_file..", "..chksum_file)
    end
    pfile:close()
end

scandir("./")
