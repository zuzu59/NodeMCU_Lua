-- fonction cat() pour afficher les 10 premières lignes d'un fichier dans la flash
print("\n head.lua   zf192026.0942   \n")

function zhead(zfile)
    print("\n"..zfile.."\n-------------------------------")

    zfilei = file.open(zfile, "r")
    i=1
    zline=file.readline()
    repeat
--      print(i..": "..string.sub(zline,1,string.len(zline)-1))
      print(string.sub(zline,1,string.len(zline)-1))
      i=i+1   zline=file.readline()
      if i>10 then break end
    until zline==nil
    file.close(zfilei)

    print("-------------------------------")
end
