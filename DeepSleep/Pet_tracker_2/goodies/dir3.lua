-- fonction dir_vers() pour afficher toutes les versions de tous les fichiers *.lua sur le NodeMCU !
-- fonction filec(fichier) pour afficher la version d'un seul fichiers sur le NodeMCU !

function dir3()
        
    print("\n 0_dir3.lua   zf200611.1714   \n")

    function file_vers(name_file)
        local z=""
        if string.find(name_file,"%.lua") then
            z=name_file..":"
            -- print("fichier: "..name_file)
            local f,i1,i2,j1,j2,k,t = f,i1,i2,j1,j2,k,t
            f = file.open(name_file, "r")
            while true do
                local t = f:readline()   if t == nil then break end
                -- recherche de l'entête de version [print("\n ]
                -- ATTENTION, il faut échapper la '(' avec un % et convertir le '\' en char(92)
                k='print%("'..string.char(92)..'n '
                i1,j1 = string.find(t,k)
                if i1 ~= nil then
                    k=string.char(92)..'n"%)'
                    i2,j2 = string.find(t,k,j1)
                    z=name_file..": "..string.sub(t,j1+1,i2-2)
                    break
                end
            end
            f:close()
            uart.write(0,".")
        end
        return z
    end

    zdir={}   list_files={}
    local k,v = k,v   local pfile = file.list()
    for k,v in pairs(pfile) do
        zdir[#zdir+1] = file_vers(k)
    end
    table.sort(zdir)   for i=1, #zdir do   print(zdir[i])   end

    dir_vers=nil   file_vers=nil   list_files=nil   zdir=nil
    dir3=nil   
    
end
dir3()

--[[

status, err = pcall(function () print(zhash("il était une fois trois petits cochons roses...")) end)  if status==false then print("Error: ",err) end

]]

