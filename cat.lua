-- fonction cat() pour afficher le contenu d'un fichier dans la flash
print("\n cat.lua   zf180730.1259")

function cat(zfile)
    print("\n-------------------------------")


    zfilei = io.open(zfile, "r")
    io.input(zfilei)

    i=1
    zline=io.read()
    repeat
      print(i..": "..zline)
      i=i+1   zline=io.read()
    until zline== nil
    io.close(zfilei)

    print("-------------------------------")
end
