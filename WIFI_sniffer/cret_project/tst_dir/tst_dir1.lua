#!/usr/local/bin/lua5.1
-- fonction dir() pour afficher les fichiers dans le dossier sur le host, donc PAS sur le NodeMCU !
-- afin d'utiliser la MEME version de Lua que sur NodeMCU (5.1) il faut installer le module 'lfs' avec:
-- luarocks --lua-dir=/usr/local/opt/lua@5.1 install lfs
-- source: https://github.com/keplerproject/luafilesystem

print("\n tst_dir1.lua   zf191110.1524   \n")

-- Lua implementation of PHP scandir function
function scandir(directory)
    local i, t, popen = 0, {}, io.popen
    local pfile = popen('ls -a "'..directory..'"')
    for filename in pfile:lines() do
        i = i + 1
        print("filename: "..filename)
        t[i] = filename
    end
    pfile:close()
    return t
end

scandir("./")
