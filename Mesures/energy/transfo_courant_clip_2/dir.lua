-- fonction dir() pour juste afficher les fichiers avec leur taille

print("\n dir2.lua   zf191223.1455   \n")

function dir()
    local zdir={}
    local pfile = file.list()
    for k,v in pairs(pfile) do
        zdir[#zdir+1] = k..string.rep(" ",24-string.len(k)).." : "..v
    end
    table.sort(zdir)   for i=1, #zdir do   print(zdir[i])   end
    size_file=nil   chksum_file=nil  k=nil
end

dir()
print("\nusage:")
print("   dir()")

--[[
dir()
dirc()
filec("dir2.lua")

=node.heap()
clear_dir()
=node.heap()

for k,v in pairs(_G) do print(k,v) end

status, err = pcall(function () print(zhash("il était une fois trois petits cochons roses...")) end)  if status==false then print("Error: ",err) end
]]
