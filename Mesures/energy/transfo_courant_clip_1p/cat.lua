-- fonction cat() pour afficher le contenu d'un fichier dans la flash
print("\n cat.lua   zf192026.0858   \n")

function cat(zfile)
    print("\n"..zfile.."\n-------------------------------")

    zfilei = file.open(zfile, "r")
    i=1
    zline=file.readline()
    repeat
--      print(i..": "..string.sub(zline,1,string.len(zline)-1))
      print(string.sub(zline,1,string.len(zline)-1))
      i=i+1   zline=file.readline()
    until zline== nil
    file.close(zfilei)

    print("-------------------------------")
end
