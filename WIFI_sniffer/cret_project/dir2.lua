-- fonction dir() pour calculer le checksum de tous les fichiers sur le NodeMCU !
-- fonction dirfile(fichier) pour calculer le checksum d'un seul fichiers sur le NodeMCU !

print("\n dir2.lua   zf191124.1522   \n")

function dir2()

    function calc_chksum_file()
        local name_file = list_files[zcmpt1]
        print(name_file)
        local size_file = 1   local chksum_file = 0
        local f = file.open(name_file, "r")
        while true do
            local t = f:read(1)   if t == nil then break end
            chksum_file = chksum_file + size_file * string.byte(t)
            size_file = size_file + 1
            if size_file%100 == 0 then uart.write(0,".") end
        end
        f:close()   print("")
        zdir[#zdir+1]=name_file..string.rep(" ",24-string.len(name_file)).." : "..size_file..", "..chksum_file
        zcmpt1 = zcmpt1 + 1
        zrepeat()
    end

    function zrepeat()
  --      if zcmpt1 < #list_files then
        if zcmpt1 <= 3 then
            node.task.post(calc_chksum_file)
        else
            table.sort(zdir)   for i=1, #zdir do   print(zdir[i])   end
            i=nil
        end
    end

    function dirc()
        zdir={}
        list_files={}
        local pfile = file.list()
        for k,v in pairs(pfile) do
            list_files[#list_files+1]=k
        end

        print(#list_files)
        zcmpt1 = 1
        zrepeat()
    end




    function filec(k)
        calc_chksum_file(k)
        print(k..string.rep(" ",24-string.len(k)).." : "..size_file..", "..chksum_file)
        size_file=nil   chksum_file=nil  k=nil
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

    dir()
    print("\nusage:")
    print("   dir()")
    print("   dirc()")
    print("   filec('dir2.lua')")

end
dir2()

--[[
dir()
dirc()
filec("dir2.lua")

for k,v in pairs(_G) do print(k,v) end

status, err = pcall(function () print(zhash("il était une fois trois petits cochons roses...")) end)  if status==false then print("Error: ",err) end
]]
