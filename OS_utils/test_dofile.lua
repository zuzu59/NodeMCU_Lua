--test si un fichier existe

print("\n test_dofile.lua zf181119.2356 \n")

f= "boot.lua"   if file.exists(f) then dofile(f) end
